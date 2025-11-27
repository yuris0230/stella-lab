class TierList < ApplicationRecord
  # 1 tier list มีหลาย entry
  has_many :tier_list_entries, dependent: :destroy
  has_many :characters, through: :tier_list_entries

  # if flag
  scope :published, -> { where(is_published: true) if column_names.include?("is_published") }

  validates :title, presence: true

  # slug URL like character / item / guide
  before_validation :set_default_slug, if: -> { respond_to?(:slug) }

  def to_param
    if self.class.column_names.include?("slug") && slug.present?
      slug
    else
      id.to_s
    end
  end

  private

  def set_default_slug
    return unless self.class.column_names.include?("slug")
    return if slug.present?
    return if title.blank?

    base = title.parameterize
    candidate = base
    counter = 2

    while self.class.where.not(id: id).exists?(slug: candidate)
      candidate = "#{base}-#{counter}"
      counter += 1
    end

    self.slug = candidate
  end
end