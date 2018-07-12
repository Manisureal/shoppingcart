class ConsignmentItem < ApplicationRecord
  belongs_to :consignment
  belongs_to :order_item
  has_one :stock
  before_save :do_before_save

  def consign_total
    # self.consignment.order.order_items.map { |qd| qd.quantity_dispatched }.sum
    self.consignment.consignment_items.map { |ci| ci.quantity }.sum
  end

  private

  def do_before_save
    self.stock = Stock.new unless self.stock
    self.stock.product = self.order_item.product
    self.stock.sale_price = self.order_item.product.price
    self.stock.cost_price = self.order_item.product.buy_price
    self.stock.product_description = self.order_item.product.description
    self.stock.stock_change = 0 - self.quantity
    self.stock.stock_message = "Dispatched Stock"
  end
end
