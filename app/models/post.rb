class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  belongs_to :deleted_by_admin, class_name: "Admin", optional: true

  validates :body, presence: true
end