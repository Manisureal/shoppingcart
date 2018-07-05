class Stock < ApplicationRecord
  belongs_to :product
  belongs_to :consignment_item
end
