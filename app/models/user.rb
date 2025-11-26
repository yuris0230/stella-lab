class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :user_profile, dependent: :destroy

  # Community relations
  has_many :posts, dependent: :destroy
  has_many :created_topics, class_name: 'Topic', foreign_key: :created_by_user_id

  # Display name used in community pages
  def display_name
    # 1) user_profile.display_name if present
    # 2) fall back to "name" column
    # 3) fall back to email prefix (before @)
    user_profile&.display_name.presence ||
      name.presence ||
      email.to_s.split('@').first
  end
end
