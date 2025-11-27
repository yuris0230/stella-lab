class Character < ApplicationRecord
  # Use enum for game-related attributes (stored as integers in DB)
  enum rarity: { unknown: 0, sr: 1, ssr: 2 }, _prefix: true
  enum element: { unknown: 0, fire: 1, water: 2, wind: 3, earth: 4, light: 5, dark: 6 }, _prefix: true
  enum weapon_type: { unknown: 0, melee: 1, ranged: 2, magic: 3 }, _prefix: true
  enum job: { unknown: 0, attacker: 1, supporter: 2, defender: 3 }, _prefix: true

  has_one_attached :portrait
  has_many :topics, as: :topicable, dependent: :destroy

  # --- Recommended equipment (items) ---
  has_many :character_recommended_items, dependent: :destroy
  has_many :recommended_items, through: :character_recommended_items, source: :item

  # --- Recommended team (other characters) ---
  has_many :character_team_members, dependent: :destroy
  has_many :recommended_teammates,
           through: :character_team_members,
           source: :teammate

  # ===================== VALIDATIONS =====================
  validates :name, presence: true, length: { maximum: 80 }
  validates :slug, presence: true, uniqueness: true

  # create && update slug before validate
  before_validation :ensure_slug

  # ===================== SCOPES =====================
  # Only show characters that are published
  scope :published, -> { where(is_published: true) }

  # Order by latest release (fallback to created_at)
  scope :recent, -> {
    order(released_on: :desc)
      .order(created_at: :desc)
  }

  # use slug in URL if no slug fallback to id.
  def to_param
    slug.presence || id.to_s
  end

  private

  # create unique slug
  def ensure_slug
    # if have slug dont
    return if slug.present? && !will_save_change_to_name?

    base = name.to_s.parameterize
    return if base.blank?

    candidate = base
    counter   = 2

    # find unique slug (except self)
    while Character.where.not(id: id).exists?(slug: candidate)
      candidate = "#{base}-#{counter}"
      counter  += 1
    end

    self.slug = candidate
  end
end