class Product < ApplicationRecord
  has_many :order_items
  audited
end
