class ProductsController < ApplicationController

  def index
      # reset_session
    @products = policy_scope(Product)
    @order_item = current_order.order_items.new
  end

  def show
    @product = Product.find(params[:id])
    authorize @product
  end
end
