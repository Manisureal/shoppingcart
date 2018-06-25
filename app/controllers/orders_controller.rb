class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
      @orders = policy_scope(Order).order("created_at desc")
      # @order_items = current_order.order_items
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
    @order.address = current_user.company ? current_user.company.address.to_s + "\n" + current_user.company.postcode.to_s : ""
    10.times do
      @order.order_items << OrderItem.new
    end
    authorize @order
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.company = current_user.company
      if @order.save
        @order.errors.full_messages
        flash[:notice] = "Order# #{@order.id}, Created Successfully"
        OrderMailer.order_submitted(@order).deliver_now
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
      flash[:notice] = "Order# #{@order.id}, Updated Successfully"
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

  def order_again
    @old_order = current_user.orders.find(params[:id])
    @order = @old_order.dup
    @order.status = "Ordered"
    @order.created_at = nil
    @order.updated_at = nil
    @old_order.order_items.each do |oi|
      noi = oi.dup
      noi.created_at = nil
      noi.updated_at = nil
      noi.quantity_dispatched = nil
      @order.order_items << noi
    end
    (10 - @old_order.order_items.count).times do
      @order.order_items << OrderItem.new
    end
    authorize @order
    render :new
  end

  private

  def order_params
    params.require(:order).permit(:notes, :address, order_items_attributes: [:id, :product_id, :quantity])
  end
end
