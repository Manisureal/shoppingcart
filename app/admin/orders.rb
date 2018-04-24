ActiveAdmin.register Order do
  permit_params :status, :total_price, :notes, :name, :address, :phone, :delivery_date, :company_id

  # menu parent: "Orders"
  # filter :title

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
        order.save
      end
    end
  end

  action_item :print, only: :show do

  end

end
