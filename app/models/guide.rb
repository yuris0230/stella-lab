class Guide < ApplicationRecord
  # Each guide is written by an admin
  belongs_to :author_admin, class_name: "Admin", foreign_key: :author_admin_id

  validates :title, :slug, :body, :category, presence: true
  validates :slug, uniqueness: true

  # Like
  has_many :likes, as: :likeable, dependent: :destroy

  # Only published guides are shown on public side
  scope :published, -> { where(is_published: true) }

  # Use slug in URLs (both public and admin)
  def to_param
    slug
  end

  before_validation :generate_slug, on: :create

  private
  # Generate a unique slug from title if empty
  def generate_slug
    return if slug.present?

    base     = title.to_s.parameterize
    candidate = base
    counter   = 2

    while Guide.exists?(slug: candidate)
      candidate = "#{base}-#{counter}"
      counter  += 1
    end

    self.slug = candidate
  end
end