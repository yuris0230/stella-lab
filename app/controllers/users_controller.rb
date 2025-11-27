class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user

    # ensure profile exists
    @profile = @user.user_profile || @user.create_user_profile!

    # Recent activity
    @recent_topics = @user.topics.order(created_at: :desc).limit(5)
    @recent_posts  = @user.posts.includes(:topic).order(created_at: :desc).limit(5)

    # Likes / bookmarks
    @liked_characters =
      Character.joins(:likes)
               .where(likes: { user_id: @user.id })
               .distinct

    @liked_guides =
      Guide.joins(:likes)
           .where(likes: { user_id: @user.id })
           .distinct

    @liked_topics =
      Topic.joins(:likes)
           .where(likes: { user_id: @user.id })
           .distinct
  end

  def destroy
    # Soft delete: set is_active = false instead of deleting row
    if (@user = current_user)
      @user.update!(is_active: false) if @user.respond_to?(:is_active)
      sign_out(@user)
    end

    redirect_to root_path, notice: "Your account has been deactivated."
  end
end