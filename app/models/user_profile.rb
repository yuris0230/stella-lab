class UserProfile < ApplicationRecord
  belongs_to :user

  validates :display_name, presence: true, length: { maximum: 24 }
  validates :bio, length: { maximum: 500 }, allow_blank: true
end
