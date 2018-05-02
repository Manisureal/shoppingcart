class Consignment < ApplicationRecord
  belongs_to :user
  belongs_to :order
  has_many :consignment_items, dependent: :destroy

  def consign_total
    self.consignment_items.map { |ci| ci.quantity * ci.order_item.product.price }.sum
  end

  def orderitem_quantity_req_tot
    self.order.order_items.map {|m| m.quantity}.sum
  end

  def dispatched_quantity
    self.consignment_items.map { |ci| ci.quantity }.sum
  end
end
