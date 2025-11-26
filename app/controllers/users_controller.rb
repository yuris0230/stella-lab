class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user

    # โหลด user_profile จาก DB (ถ้าไม่มีให้สร้างว่าง ๆ ไว้เลย)
    @profile = @user.user_profile || @user.create_user_profile!

    # กิจกรรมล่าสุด
    @recent_topics = @user.topics.order(created_at: :desc).limit(5)
    @recent_posts  = @user.posts.includes(:topic).order(created_at: :desc).limit(5)
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: "Your account has been deleted."
  end
end