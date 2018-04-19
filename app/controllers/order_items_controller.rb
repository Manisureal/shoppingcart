class OrderItemsController < ApplicationController

  def create
    @order = current_order
    @order.status = "Initiated"
    @item = @order.order_items.new(item_params)
    authorize @item
    @item.save
    session[:order_id] = @order.id
    @order.user_id = current_user.id
    redirect_to products_path
  end

  def destroy
    @item = OrderItem.find(params[:id])
    @item.destroy
    flash[:notice] = "#{@item.product.name} successfully removed from basket"
    redirect_to cart_path
  end

  private

  def item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
