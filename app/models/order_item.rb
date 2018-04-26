class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: :true
  validates :quantity, presence: :true

  def total
    self.product ? self.quantity.to_i * self.product.price : 0.0
  end
  #Retrives the quantity to dispatch
  def to_dispatch
    self.quantity - self.quantity_dispatched
  end
  #Updates the new retrieved quantity value with the remaining to be dispatched to close the order and mark as disptached
  def to_dispatch=(q)
    self.quantity_dispatched += q.to_i
  end

end
