class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Profile (My Page)
  has_one :user_profile, dependent: :destroy

  # Like
  has_many :likes, dependent: :destroy

  # Community relations
  # Topic model: belongs_to :created_by_user, class_name: "User", foreign_key: :created_by_user_id
  has_many :topics,
           foreign_key: :created_by_user_id,
           inverse_of: :created_by_user,
           dependent: :nullify

  has_many :posts, dependent: :nullify

  # Build default user_profile after sign-up
  after_create :build_default_profile

  # Soft delete support: allow login only if is_active is true
  def active_for_authentication?
    base = super
    # If users table has is_active column, use it; otherwise keep old behavior
    if has_attribute?(:is_active)
      base && is_active?
    else
      base
    end
  end

  # Optional message when inactive (uses Devise i18n if set)
  def inactive_message
    if has_attribute?(:is_active) && !is_active?
      :inactive_account
    else
      super
    end
  end

  private

  # Create basic profile so My Page always has data
  def build_default_profile
    return if user_profile.present?

    display =
      if respond_to?(:name) && name.present?
        name
      else
        "User#{id}"
      end

    create_user_profile!(
      display_name: display,
      bio: ""
    )
  rescue ActiveRecord::RecordInvalid
    # Do nothing if profile creation fails (don't break sign-up)
  end
end