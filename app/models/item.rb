class Item < ApplicationRecord
  # Enum for rarity and item type (stored as integers)
  enum rarity: { unknown: 0, sr: 1, ssr: 2 }, _prefix: true
  enum item_type: { weapon: 0, armor: 1, accessory: 2, material: 3 }, _prefix: true

  # Only show items that are published
  scope :published, -> { where(is_published: true) }

  # Order by latest release (fallback to created_at)
  scope :recent, -> {
    order(released_on: :desc)
      .order(created_at: :desc)
  }

  # Use slug in URLs if present
  def to_param
    slug.presence || id.to_s
  end
end