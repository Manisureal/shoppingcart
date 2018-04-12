class OrderItemsController < ApplicationController

  def create
    @order = current_order
    @order.status = "Initiated"
    # @order.total_price = calculate_total
    @item = @order.order_items.new(item_params)
    @item.save
    session[:order_id] = @order.id
    redirect_to products_path
  end

  def destroy
    @item = OrderItem.find(params[:id])
    @item.destroy
    flash[:notice] = "#{@item.product.name} successfully removed from basket"
    redirect_to cart_path
  end

  # def calculate_total
  #   @order_items.map { |item| item.product.price * item.quantity.to_i }.sum
  # end

  private

  def item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end

end
