class Order < ApplicationRecord
  has_many :order_items
  # has_one :user
  belongs_to :user
  # before_save :update_total
  # before_save :update_total
  # after_save :update_total
  # around_save :update_total
  # before_create :update_total
  # after_create :update_total
  # after_create :reset_current_session
  # around_create :update_total

  before_create :update_status
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: lambda { |oi| oi[:product_id].blank? }
  validates :order_items, presence: :true


  # def reset_current_session
  #   self.session[:order_id] = nil
  # end

  def total_quantity
    self.order_items.map { |oi| oi.quantity }.sum
  end

  # public methods can be used in views/controllers if needed to be
  def calculate_total
    self.order_items.map { |item| item.product.price*item.quantity.to_i }.sum
  end

  private
  # Methods should always be private if they will be used within a model onlu

  def update_status
    if self.status.nil?
      self.status = "Ordered"
    end
  end

  def update_total
    self.total_price = calculate_total
  end

end
