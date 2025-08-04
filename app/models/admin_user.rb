require "bcrypt"

class AdminUser < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: %w[admin editor] }

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
