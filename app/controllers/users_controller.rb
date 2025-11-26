class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user  = current_user
    @posts = @user.posts.order(created_at: :desc)
    
    # Recent activity for this user
    @recent_topics = @user.topics.order(created_at: :desc).limit(5)
    @recent_posts  = @user.posts.includes(:topic).order(created_at: :desc).limit(5)
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: "Your account has been deleted."
  end
end