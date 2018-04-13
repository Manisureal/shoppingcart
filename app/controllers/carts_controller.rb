class CartsController < ApplicationController
  def show

    @order_items = current_order.order_items
    # require
  end

  def destroy
    @cart_items = current_order.order_items
    @cart_items.destroy_all
    if current_order.id != nil?
      session[:order_id] = nil
    end
    Order.first.delete
    redirect_to products_path
  end

  def create

  end
end
