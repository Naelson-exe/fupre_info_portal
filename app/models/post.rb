class Post < ApplicationRecord
  belongs_to :admin_user

  # Status management
  enum :status, { draft: 0, published: 1, archived: 2 }
  attribute :post_type, :integer
  enum :post_type, { announcement: 0, memo: 1 }
  attribute :severity, :integer
  enum :severity, { low: 0, medium: 1, high: 2 }
  enum :source, { vc_office: 0, registrar: 1, bursary: 2, dean_of_students: 3 }

  validates :status, inclusion: { in: statuses.keys }
  validates :post_type, inclusion: { in: post_types.keys }
  validates :severity, inclusion: { in: severities.keys }
  validates :source, inclusion: { in: sources.keys }
  validates :title, presence: true, length: { minimum: 3, maximum: 255 }
  validates :content, presence: true
  validates :summary, length: { maximum: 500 }, allow_blank: true

  # Timestamps
  before_save :set_published_at, if: -> { status_changed? && status == "published" }

  # Search scopes
  scope :with_title, ->(query) { where("LOWER(title) LIKE ?", "%#{query.downcase}%") }
  scope :with_content, ->(query) { where("LOWER(content) LIKE ?", "%#{query.downcase}%") }
  scope :with_summary, ->(query) { where("LOWER(summary) LIKE ?", "%#{query.downcase}%") }
  scope :with_status, ->(status) { where(status: status) }
  scope :published, -> { where(status: :published) }
  scope :draft, -> { where(status: :draft) }
  scope :recent, -> { order(created_at: :desc) }
  scope :search, ->(query) {
    if query.present?
      with_title(query).or(with_content(query)).or(with_summary(query))
    else
      all
    end
  }

  # Instance methods
  def formatted_date
    (published_at || created_at).strftime("%B %d, %Y")
  end

  def excerpt(length = 100)
    return summary if summary.present?
    content.truncate(length, separator: " ")
  end

  private

  def set_published_at
    self.published_at = Time.current
  end
end
