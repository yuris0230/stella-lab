# Join model between Character and Item for "recommended equipment"
class CharacterRecommendedItem < ApplicationRecord
  belongs_to :character
  belongs_to :item

  # optional short note like "Best in slot", "Budget option", etc.
  validates :character_id, uniqueness: { scope: :item_id }
end