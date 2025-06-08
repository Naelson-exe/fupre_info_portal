class Event < ApplicationRecord
  belongs_to :admin_user

  # Validations
  validates :title, presence: true, length: { minimum: 3, maximum: 255 }
  validates :details, presence: true
  validates :event_date, presence: true
  validates :admin_user, presence: true

  # Scopes
  scope :upcoming, -> { where("event_date >= ?", Date.current) }
  scope :past, -> { where("event_date < ?", Date.current) }
  scope :today, -> { where(event_date: Date.current) }
  scope :search, ->(query) {
    if query.present?
      where("LOWER(title) LIKE ? OR LOWER(details) LIKE ?",
            "%#{query.downcase}%", "%#{query.downcase}%")
    else
      all
    end
  }

  # Instance methods
  def full_date
    if event_time.present?
      "#{event_date.strftime('%B %d, %Y')} at #{event_time.strftime('%I:%M %p')}"
    else
      "#{event_date.strftime('%B %d, %Y')} (All day)"
    end
  end
end
