class Consignment < ApplicationRecord
  belongs_to :user
  belongs_to :order
  has_many :consignment_items, dependent: :destroy
end
