class ProductsController < ApplicationController
  def index
    # if !session[:order_id].nil?
      # reset_session
    # end

    @products = Product.all
    @order_item = current_order.order_items.new
  end
end
