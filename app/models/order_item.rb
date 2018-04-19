class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: :true
  validates :quantity, presence: :true
end
