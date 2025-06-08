require 'bcrypt'

class AdminUser < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :password, length: { minimum: 8 }, allow_blank: true, on: :update

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
