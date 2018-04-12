class CartsController < ApplicationController
  def show
    @cart = current_order
    @order_items = current_order.order_items
  end

  def destroy
    @cart = current_order
    @cart.destroy
    session[:order_id] = nil
    redirect_to products_path
  end
end
