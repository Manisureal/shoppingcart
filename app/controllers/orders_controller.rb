class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
      @orders = policy_scope(Order)
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

  def new
    @order = Order.new
    10.times do
      @order.order_items << OrderItem.new
    end
    authorize @order
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
      if @order.save
        @order.errors.full_messages
        redirect_to orders_path
        authorize @order
      else
        Rails.logger.info "************ #{@order.order_items.count}"
        (10 - @order.order_items.count).times do
          @order.order_items << OrderItem.new
        end
        render :new
        authorize @order
      end
  end

  def edit
    @order = current_user.orders.find(params[:id])
    (10 - @order.order_items.count).times do
      @order.order_items << OrderItem.new
    end
    authorize @order
  end

  def update
    @order = current_user.orders.find(params[:id])
    if @order.update(order_params)
      redirect_to orders_path
      authorize @order
    else
      (10 - @order.order_items.count).times do
        @order.order_items << OrderItem.new
      end
      render :edit
      authorize @order
    end
  end

  private

  def order_params
    params.require(:order).permit(:notes, order_items_attributes: [:id, :product_id, :quantity])
  end
end
