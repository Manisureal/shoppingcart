class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @item = @order.order_items.new(item_params)
    @item.save
    session[:order_id] = @order.id
    redirect_to products_path
  end

  def destroy
    @item = OrderItem.find(params[:id])
    @item.destroy
    flash.now[:notice] = "Item has successfully been deleted!"
    redirect_to cart_path
  end

  private

  def item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end

end
