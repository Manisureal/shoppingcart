class OrdersController < ApplicationController
  def index
    # require
      @orders = policy_scope(Order)
      # require
      @order_items = current_order.order_items
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
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
