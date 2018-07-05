class Product < ApplicationRecord
  has_many :order_items
  has_many :stocks
  audited

  def current_stock
    self.stocks.sum(:stock_change)
  end
end
