class MyPageController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @likes = @user.likes.includes(:likeable)

    @liked_characters = @likes.select { |l| l.likeable.is_a?(Character) }.map(&:likeable)
    @liked_guides = @likes.select { |l| l.likeable.is_a?(Guide) }.map(&:likeable)
    @liked_topics = @likes.select { |l| l.likeable.is_a?(Topic) }.map(&:likeable)
  end
end