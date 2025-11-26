class Character < ApplicationRecord
  # Use enum for game-related attributes (stored as integers in DB)
  enum rarity: { unknown: 0, sr: 1, ssr: 2 }, _prefix: true
  enum element: { unknown: 0, fire: 1, water: 2, wind: 3, earth: 4, light: 5, dark: 6 }, _prefix: true
  enum weapon_type: { unknown: 0, melee: 1, ranged: 2, magic: 3 }, _prefix: true
  enum job: { unknown: 0, attacker: 1, supporter: 2, defender: 3 }, _prefix: true

  has_many :topics, as: :topicable, dependent: :destroy

  # Only show characters that are published
  scope :published, -> { where(is_published: true) }

  # Order by latest release (fallback to created_at)
  scope :recent, -> {
    order(released_on: :desc)
      .order(created_at: :desc)
  }

  # For now, use slug if present, otherwise fall back to id
  def to_param
    # This makes URLs like /characters/stella instead of /characters/1
    slug.presence || id.to_s
  end
end