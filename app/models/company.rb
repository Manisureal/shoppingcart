class Company < ApplicationRecord
  has_many :users
  has_many :orders
  has_many :consignments, through: :orders
end
