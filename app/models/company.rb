class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :orders
  has_many :consignments, through: :orders
  validates :email, presence: true
  audited

  # geocoded_by :geocoder_address
  geocoded_by :postcode
  after_validation :geocode, if: :postcode_changed?

  # def geocoder_address
  #   [address, postcode].compact.join(', ')
  # end
end
