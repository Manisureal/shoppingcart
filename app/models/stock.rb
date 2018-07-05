class Stock < ApplicationRecord
  belongs_to :product
  belongs_to :consignment_item
  # Before Create only creates an instance once which is good otherwise
  # before_save can be used but this is called every time update is triggered
  before_create :do_before_create

  private
  # Private Methods are not visible to instances of classes e.g. @stock = Stock.somthing
  # Only visible in this file and to this Class(Stock) itself
  def do_before_create
    self.product_description = self.product.description
    self.sale_price = self.product.price
  end
end
