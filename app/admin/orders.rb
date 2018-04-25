ActiveAdmin.register Order do
  permit_params :status, :total_price, :notes, :name, :address, :phone, :delivery_date, :company_id, :taken_by,
    order_items_attributes: [:id, :product_id, :quantity, :quantity_dispatched]



  index do
    column "Order#", :id do |o|
      link_to o.id, admin_order_path(o)
    end
    column :status do |s|
      status_tag(s.status, class: s.status == "Ordered" ? "error" : "done")
    end
    column :total_price
    column :created_at
    column "Customer", :user_id do |u|
      link_to u.user.forname + " " + u.user.surname, admin_user_path(u.user_id)
    end
    column :company
    column "Admin Assigned", :taken_by
    actions
  end

  scope :all
  scope("In Progress") { |scope| scope.where(status: "In Progress")}
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
      # f.input :quantity_dispatched
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
  end

  action_item :print, only: :show do
    #Creates an additional action button next to edit, delete etc
  end

end
