class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :topics, through: :taggings

  validates :name, :slug, presence: true
end