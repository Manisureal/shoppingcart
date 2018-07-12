class Stock < ApplicationRecord
  belongs_to :product
  belongs_to :consignment_item, optional: true
  before_create :do_before_create

  def created_date
    self.created_at.to_date
  end

  private
  # Private Methods are not visible to instances of classes e.g. stock = S.somthing
  # Only visible in this file and to this Class(Stock) itself
  def do_before_create
    self.product_description = self.product.description
    self.sale_price = self.product.price
    self.cost_price = self.product.buy_price
  end

end
