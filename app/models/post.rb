class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  belongs_to :deleted_by_admin, class_name: 'Admin', optional: true

  # Basic validation for comment body
  validates :body, presence: true, length: { maximum: 2000 }

  # Only show posts that are not soft-deleted
  scope :visible, -> { where(is_deleted: false) }
end