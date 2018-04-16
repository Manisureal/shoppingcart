class ProductsController < ApplicationController
  # skip_before_action :authenticate_user!
  def index
    # if !session[:order_id].nil?
      # reset_session
    # end

    @products = Product.all
    # @user = current_user
    @order_item = current_order.order_items.new
  end
end
