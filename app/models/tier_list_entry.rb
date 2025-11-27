class TierListEntry < ApplicationRecord
  belongs_to :tier_list
  belongs_to :character

  # if use string tier ex) "S", "A" still use order(:tier_rank)
  # if have another column for sort (ex. position) add next time.
  default_scope { order(:tier_rank) }

  validates :tier_rank, presence: true

  # delegate for view
  delegate :name, :portrait, :job, :element, to: :character, prefix: true
end