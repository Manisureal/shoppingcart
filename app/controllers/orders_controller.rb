class OrdersController < ApplicationController
  def index
    # if !current_order.order_items.empty?
    # if current_order.save
    # require
      @orders = Order.all
      @order_items = current_order.order_items
    # end
  # end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def destroy
    # @order = Order.find(params[:id])
    # @order.destroy
    # redirect_to products_path
  end

  # only if i want the user to delete the order
  # then we need to add delete method here
end
