class Event < ApplicationRecord
  belongs_to :admin_user

  validates :title, presence: true, length: { minimum: 3, maximum: 255 }
  validates :details, presence: true
  validate :start_date_or_end_date_present

  scope :upcoming, -> { where("start_date >= ? OR end_date >= ?", Date.current, Date.current).order(start_date: :asc) }
  scope :past, -> { where("start_date < ? AND (end_date < ? OR end_date IS NULL)", Date.current, Date.current).order(start_date: :desc) }
  scope :search, ->(query) {
    if query.present?
      where("LOWER(title) LIKE :q OR LOWER(details) LIKE :q", q: "%#{query.downcase}%")
    else
      all
    end
  }

  # Instance methods
  def formatted_date
    if start_date.present?
      start_date.strftime("%B %d, %Y")
    elsif end_date.present?
      end_date.strftime("%B %d, %Y")
    end
  end

  def full_date
    if event_time.present?
      "#{formatted_date} at #{event_time.strftime('%I:%M %p')}"
    else
      "#{formatted_date} (All day)"
    end
  end

  def deadline?
    event_type == "deadline"
  end

  def start_time
    start_date
  end

  private

  def start_date_or_end_date_present
    unless start_date.present? || end_date.present?
      errors.add(:base, "Either start date or end date must be present")
    end
  end

  def excerpt(length = 100)
    details.truncate(length, separator: " ")
  end
end
