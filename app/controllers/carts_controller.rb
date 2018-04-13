class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
    #
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
    @order = current_order
    # @order_items = OrderItem.find(current_order)
    # @order_items = current_order.order_items
    @order.status = "pending"
    @order.order_items.each { |oi| oi.id = nil }
    # Order.last.total_price
    # Order.last.total_quantity
    # @order.order_items = current_order.order_items
    # @order_items.total_quantity
    # @order.total_price = calculate_total

    @order.save!
    # @cart_items = current_order.order_items
    # @cart_items.destroy_all
    # require
    # Order.destroy(session[:order_id])
    # require
    session[:order_id] = nil
    redirect_to orders_path

    # require

  end
end
