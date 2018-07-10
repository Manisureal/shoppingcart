class Product < ApplicationRecord
  has_many :order_items
  has_many :stocks
  audited

  def stock_count_on(date)
    self.stocks.where('created_at <= ?', date.to_time.end_of_day).sum(:stock_change)
  end

  def current_stock
    self.stocks.sum(:stock_change)
  end
end
