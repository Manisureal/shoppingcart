class Product < ApplicationRecord
  has_many :order_items
  has_many :stocks
  # after_initialize :current_stock_level
  audited

  def self.grand_total_calc(date,column_name)
    self.all.map { |p| p.stocks.where('created_at <= ?', date.to_time.end_of_day).sum(column_name) }.compact.sum
  end

  def self.grand_stock_total(date)
    grand_total_calc(date,:stock_change)
  end

  def self.grand_sale_value_total(date)
    # self.all.map { |p| p.stocks.where('created_at <= ?', date.to_time.end_of_day).sum('sale_price*stock_change') }.sum
    grand_total_calc(date,'sale_price*stock_change')
  end

  def self.grand_cost_value_total(date)
    grand_total_calc(date,'cost_price*stock_change')
  end

  # Old method refactored to re-usable

  # def self.grand_stock_total(date)
  #   all_products_stocks = self.all.map { |p| p.stocks.where('created_at <= ?', date.to_time.end_of_day).sum(:stock_change) }.compact
  #   all_products_stocks.sum
  # end

  def stock_counts(date,column_name)
    self.stocks.where('created_at <= ?', date.to_time.end_of_day).sum(column_name)
  end

  def stock_count_on(date)
    stock_counts(date,:stock_change)
    # self.stocks.where('created_at <= ?', date.to_time.end_of_day).sum(:stock_change)
  end

  def total_stock_sale_value(date)
    stock_counts(date,'sale_price*stock_change')
    # stock_counts(date,:sale_price) * stock_count_on(date)
    # self.stocks.where('created_at <= ?', date.to_time.end_of_day).distinct(:sale_price).sum(:sale_price) * stock_count_on(date)
    # self.stocks.where('created_at <= ?', date.to_time.end_of_day).sum('sale_price*stock_change')

  end

  def total_stock_cost_value(date)
    stock_counts(date,'cost_price*stock_change')
    # self.buy_price == nil ? 0.00 : self.buy_price * stock_count_on(date)
    # stock_counts(date,:cost_price) * stock_count_on(date)
    # self.stocks.where('created_at <= ?', date.to_time.end_of_day).sum('cost_price*stock_change')
  end

  def current_stock_level
    self.stocks.sum(:stock_change)
    # self.current_stock = self.stocks.sum(:stock_change)
    # self.save
  end
end
