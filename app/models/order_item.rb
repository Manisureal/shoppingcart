class OrderItem < ApplicationRecord
  # same as the full function below
  attr_accessor :to_dispatch_direct
  belongs_to :order
  belongs_to :product, optional: :true
  has_many :consignment_items
  validates :quantity, presence: { message: "Please specify Quantity" }
  # accepts_nested_attributes_for :consignment_items

  audited

  # @to_dispatch_direct = 0

  def total
    self.product ? self.quantity.to_i * self.product.price : 0.0
  end

  #Retrives the quantity to dispatch #getter method(virtual attrs)
  def to_dispatch
    self.quantity - self.quantity_dispatched.to_i
  end

  #Updates the new retrieved quantity value with the remaining to be dispatched to close the order and mark as disptached
  #setter method(virtual attrs)
  def to_dispatch=(q)
    self.incomplete_quantity = q
    self.quantity_dispatched.nil? ? self.quantity_dispatched = q : self.quantity_dispatched += q.to_i
  end

  # attr_accessor(virtual attrs/getters&setters) full method
  # def to_dispatch_direct
  #   @to_dispatch_direct
  # end

  # def to_dispatch_direct=(val)
  #   @to_dispatch_direct = val
  # end
end
