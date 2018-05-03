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

  def item_details
    disp = ""
    first = true
    self.consignment_items.each do |ci|
      disp += ", " unless first
      first = false
      disp += "#{ci.order_item.product.name} (#{ci.quantity} of #{ci.order_item.quantity})"
    end
    disp
  end
end
