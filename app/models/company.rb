class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :orders
  has_many :consignments, through: :orders
  validates :email, format: { with: /\A.*@.*\.com\z/ }, presence: true
  validate :check_contact_name
  audited

  # geocoded_by :geocoder_address
  geocoded_by :postcode
  after_validation :geocode, if: :postcode_changed?

  # def geocoder_address
  #   [address, postcode].compact.join(', ')
  # end
  private

  def check_contact_name
    if contact_name.empty?
      errors.add(:contact_name, "can't be blank")
    elsif contact_name.split.length > 0 && contact_name.split.length < 2
      errors.add(:contact_name, "must include both Forenames and Surnames")
    end
  end
end
