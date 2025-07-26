class Event < ApplicationRecord
  belongs_to :admin_user

  validates :title, presence: true, length: { minimum: 3, maximum: 255 }
  validates :event_date, presence: true
  validates :details, presence: true

  scope :upcoming, -> { where("event_date >= ?", Date.current).order(event_date: :asc) }
  scope :past, -> { where("event_date < ?", Date.current).order(event_date: :desc) }
  scope :search, ->(query) {
    if query.present?
      where("LOWER(title) LIKE :q OR LOWER(details) LIKE :q", q: "%#{query.downcase}%")
    else
      all
    end
  }

  # Instance methods
  def formatted_date
    event_date.strftime("%B %d, %Y")
  end

  def full_date
    if event_time.present?
      "#{formatted_date} at #{event_time.strftime('%I:%M %p')}"
    else
      "#{formatted_date} (All day)"
    end
  end

  def excerpt(length = 100)
    details.truncate(length, separator: " ")
  end
end
