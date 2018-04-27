ActiveAdmin.register Order do
  permit_params :status, :total_price, :notes, :name, :address, :phone, :delivery_date, :company_id, :taken_by,
    order_items_attributes: [:id, :product_id, :quantity, :to_dispatch]

  index do
    selectable_column
    column "Order#", :id do |o|
      link_to o.id, admin_order_path(o)
    end
    column :status do |s|
      status_tag(s.status, class: (s.status == "Ordered") ? "error" : (s.status == "In Progress") ? "blue" : (s.status == "Incomplete") ? "warning" : "done")
    end
    column :total_price do |tp|
      number_to_currency tp.total_price
    end
    column :created_at
    # column "Disptached At", :updated_at do |ua|
    #   (ua.status == "Dispatched") ? ua.updated_at : "Not Yet Dispatched - #{ua.status}"
    # end
    column "Customer", :user_id do |u|
      link_to u.user.forname + " " + u.user.surname, admin_user_path(u.user_id)
    end
    column :company
    column "Admin Assigned", :taken_by
    actions
  end

  scope :all
  scope("Ordered") { |scope| scope.where(status: "Ordered")}
  scope("In Progress") { |scope| scope.where(status: "In Progress")}
  scope("In Complete") { |scope| scope.where(status: "Incomplete")}
  scope("Completed") { |scope| scope.where(status: ["Completed", "Dispatched"])}

  show do
    @order = Order.find(params[:id])
    render 'show_partial', { order: @order }
  end

  form do |f|
    f.inputs "Identity" do
      f.input :user
      f.input :company
      f.input :status, collection: ["Ordered","In Progress", "Completed", "Dispatched", "Cancelled", "Incomplete"]
      f.input :total_price
      f.input :notes
      f.input :name
      f.input :address
      f.input :phone
      f.input :delivery_date
      f.input :taken_by
    end
    f.actions
  end

  controller do
    def show
      if params[:take_order] == "true"
        order = Order.find(params[:id])
        order.status = "In Progress"
        order.taken_by = current_user.forname + " " + current_user.surname
        order.save
      end
    end

    def update
      @order = Order.find(params[:id])
      if @order.update_attributes(permitted_params[:order])
        if @order.status == "Incomplete"
          @new_consignment = Consignment.create!(user: current_user, order: @order, shipped_at: Time.now, tracking_no: nil)
          # @new_consignment.order_id = @order.id
          require
          redirect_to admin_root_path, alert: "Order# #{@order.id} has been marked as Incomplete"
        elsif @order.status == "Dispatched"
          @new_consignment = Consignment.create!(user: current_user, order: @order, shipped_at: Time.now, tracking_no: nil)
          redirect_to admin_root_path, notice: "Order# #{@order.id} was successfully marked as Dispatched"
        end
        # redirect_to admin_orders_path, alert: (@order.status == "Incomplete") ? "Order has been marked as Incomplete"  : (@order.status == "Dispatched") ? "Order was successfully marked Dispatched" : "null"
      else
        render :edit
      end
    end

  end

  action_item :print, only: :show do
    #Creates an additional action button next to edit, delete etc
  end

end
