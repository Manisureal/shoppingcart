class Order < ApplicationRecord
  has_many :order_items
  # before_save :update_total
  # before_save :update_total
  after_save :update_total
  # around_save :update_total
  # before_create :update_total
  # after_create :update_total
  # around_create :update_total

  before_create :update_status

  # public methods can be used in views/controllers if needed to be
  def calculate_total
    self.order_items.map { |item| item.product.price*item.quantity }.sum
  end

  private
  # Methods should always be private if they will be used within a model onlu

  def update_status
    if self.status == nil?
      self.status = "In Progress"
    end
  end

  def update_total
    self.total_price = calculate_total
  end

end
