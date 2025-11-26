class UserProfile < ApplicationRecord
  belongs_to :user

  validates :display_name, presence: true, length: { maximum: 24 }
  validates :bio, ength: { maximum: 500 }
end
