class Guide < ApplicationRecord
  belongs_to :author_admin, class_name: "Admin"

  validates :title, :slug, :body, :category, presence: true
end