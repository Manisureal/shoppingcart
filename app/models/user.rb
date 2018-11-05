class User < ApplicationRecord
  has_many :orders
  belongs_to :company
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  audited

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
