class OrdersController < ApplicationController
  def index
    if !current_order.order_items.empty?
    @orders = Order.all
  end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end
end
