ActiveAdmin.register Order do
  permit_params :status, :total_price, :notes, :name, :address, :phone, :delivery_date, :company_id, :taken_by

  index do
    column "Order#", :id do |o|
      link_to o.id, admin_order_path(o)
    end
    column :status
    column :total_price
    column :created_at
    column "Customer", :user_id do |u|
      # require
      link_to u.user.forname + " " + u.user.surname, admin_user_path(u.user_id)
    end
    column :company
    column "Admin Assigned", :taken_by
    actions
  end

  scope :all
  scope("In Progress") { |scope| scope.where(status: "In Progress")}
  scope("Completed") { |scope| scope.where(status: ["Completed"])}

  show do
    @order = Order.find(params[:id])
    render 'show_partial', { order: @order }
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
