class TierListEntry < ApplicationRecord
  belongs_to :tier_list
  belongs_to :character
end