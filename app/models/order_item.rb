class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: :true
  validates :quantity, presence: :true

  def total
    self.product ? self.quantity.to_i * self.product.price : 0.0
  end
end
