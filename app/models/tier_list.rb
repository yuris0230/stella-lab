class TierList < ApplicationRecord
  has_many :tier_list_entries, dependent: :destroy

  validates :title, presence: true
end