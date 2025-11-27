# Join model for character recommended team members
class CharacterTeamMember < ApplicationRecord
  belongs_to :character
  belongs_to :teammate, class_name: "Character"

  # prevent duplicate teammate for same character
  validates :character_id, uniqueness: { scope: :teammate_id }
end