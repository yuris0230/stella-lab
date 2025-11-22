class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user  = current_user
    @posts = @user.posts.order(created_at: :desc)
  end

  def destroy
    user = current_user
    user.destroy
    reset_session
    redirect_to new_user_registration_path, notice: "退会が完了しました。ご利用ありがとうございました。"
  end
end