class Topic < ApplicationRecord
  # Topic can belong to different parents in the future (character, item, etc.)
  # For now we mainly use it as a community board, so topicable is optional.
  belongs_to :topicable, polymorphic: true, optional: true

  # User who created this topic
  belongs_to :creator, class_name: 'User', foreign_key: :created_by_user_id

  has_many :posts, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # Status of this topic (more states can be added later)
  enum status: { open: 0, closed: 1, archived: 2 }, _prefix: true

  validates :title, presence: true, length: { maximum: 120 }

  # Sort pinned topics first, then by recent update
  scope :ordered, -> { order(pinned: :desc, updated_at: :desc) }
end