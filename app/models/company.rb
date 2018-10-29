class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :orders
  has_many :consignments, through: :orders
  validates :email, presence: true
  audited
end
