class Topic < ApplicationRecord
  belongs_to :topicable, polymorphic: true
  belongs_to :creator, class_name: "User", foreign_key: "created_by_user_id"

  enum status: { open: 0, closed: 1 }
end