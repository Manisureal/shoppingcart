class Order < ApplicationRecord
  has_many :consignments
  has_many :order_items
  belongs_to :user
  belongs_to :company
  before_create :update_status
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: lambda { |oi| oi[:product_id].blank? }
  validates :order_items, presence: { message: "Please choose an item" }
  after_update :update_total
  after_create :update_total
  before_create :update_total
  before_save :update_total
  before_save :check_quantity_match
  audited

  def total_quantity
    self.order_items.map { |oi| oi.quantity }.sum
  end

  # public methods can be used in views/controllers if needed to be
  def calculate_total
    self.order_items.map { |item| item.total }.sum
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

  def check_quantity_match
    if self.status == "In Progress" || self.status == "Incomplete"
      complete = true
      self.order_items.each do |oi|
        complete = false if oi.quantity != oi.quantity_dispatched
      end
      self.status = complete ? "Dispatched" : "Incomplete"
    end
  end
end
