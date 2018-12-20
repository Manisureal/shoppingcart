class ConsignmentItem < ApplicationRecord
  # attr_accessor :to_dispatch_direct
  belongs_to :consignment
  belongs_to :order_item
  has_many :stocks
  before_save :create_stock_dispatch

  def consign_total
    # self.consignment.order.order_items.map { |qd| qd.quantity_dispatched }.sum
    self.consignment.consignment_items.map { |ci| ci.quantity.nil? ? 0 : ci.quantity }.sum
  end

  private

  def create_stock_dispatch
    if self.order_item.product.non_stock == false
      if self.order_item.to_dispatch_direct
        stock_out = self.stocks.new
        stock_out.product = self.order_item.product
        stock_out.sale_price = self.order_item.product.price
        stock_out.cost_price = self.order_item.product.buy_price
        stock_out.product_description = self.order_item.product.description
        stock_out.stock_change = 0 - self.quantity.to_i
        stock_out.stock_message = "- Direct Dispatch"
        # stock_out.save
        stock_in = self.stocks.new
        stock_in.product = self.order_item.product
        stock_in.sale_price = self.order_item.product.price
        stock_in.cost_price = self.order_item.product.buy_price
        stock_in.product_description = self.order_item.product.description
        stock_in.stock_change = self.quantity.to_i
        stock_in.stock_message = "+ Direct Dispatch"
        # stock_in.save
      else
        stock_out = self.stocks.new #unless self.stocks
        stock_out.product = self.order_item.product
        stock_out.sale_price = self.order_item.product.price
        stock_out.cost_price = self.order_item.product.buy_price
        stock_out.product_description = self.order_item.product.description
        stock_out.stock_change = 0 - self.quantity.to_i
        stock_out.stock_message = "Dispatched Stock"
        # stock_out.save
      end
    end
  end
end
