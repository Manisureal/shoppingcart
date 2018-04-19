class CartsController < ApplicationController
  def show
    # reset_session
    @order_items = current_order.order_items
    authorize @order_items
    # require
  end

  def destroy
    @cart_items = current_order.order_items
    @cart_items.destroy_all
    if current_order.id != nil?
      session[:order_id] = nil
    end
    authorize @cart_items
    Order.last.destroy
    redirect_to products_path
  end

  def create
    @order = current_order
    @order.user_id = current_user.id
    @order.status = "pending"
    @order.order_items.each { |oi| oi.id = nil }
    @order.save!
    authorize @order
    session[:order_id] = nil
    redirect_to orders_path
  end
end
