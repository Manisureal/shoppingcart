class ConsignmentItem < ApplicationRecord
  belongs_to :consignment
  belongs_to :order_item

  def consign_total
    # self.consignment.order.order_items.map { |qd| qd.quantity_dispatched }.sum
    self.consignment.consignment_items.map { |ci| ci.quantity }.sum
  end
end
