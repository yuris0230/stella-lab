class SiteText < ApplicationRecord
  # Each record is identified by a unique "key" (e.g. "home_game_info")
  validates :key, presence: true, uniqueness: true

  # Helper: get only the body by key (returns nil if not found)
  def self.fetch_body(key)
    find_by(key: key)&.body
  end

  # Helper: get only the title by key
  def self.fetch_title(key)
    find_by(key: key)&.title
  end
end