ActiveAdmin.register OrderItem do
  # menu false
  belongs_to :order

  controller do
    def destroy
      @order_item = OrderItem.find(params[:id])
      destroy! do |format|
        format.js # { flash[:notice] = "Order Item ##{@order_item.id}, deleted successfully!" }
      end
    end
  end
end
