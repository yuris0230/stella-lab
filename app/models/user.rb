class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :user_profile, dependent: :destroy

  # User can create topics and posts in community
  has_many :topics,
           foreign_key: :created_by_user_id,
           inverse_of: :created_by_user,
           dependent: :nullify
  has_many :posts,  dependent: :nullify

  # Create default profile after user is created
  after_create :build_default_profile

  private
  # Build a basic profile so My Page always has something to show
  def build_default_profile
    return if user_profile.present?

    create_user_profile!(
      display_name: (respond_to?(:name) && name.present?) ? name : "User#{id}",
      bio: ""
    )
  rescue ActiveRecord::RecordInvalid
    # If something goes wrong, do nothing (avoid breaking sign-up)
  end
end