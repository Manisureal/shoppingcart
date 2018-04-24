ActiveAdmin.register Order do
  permit_params :status, :total_price, :notes, :name, :address, :phone, :delivery_date, :company_id

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
