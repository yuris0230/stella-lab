class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    likeable = find_likeable

    # toggle: if like > unlike, nolike > like
    like = current_user.likes.find_by(likeable: likeable)

    if like
      like.destroy
      message = "Removed from likes."
    else
      current_user.likes.create!(likeable: likeable)
      message = "Added to likes."
    end

    redirect_back fallback_location: root_path, notice: message
  rescue ActiveRecord::RecordNotFound
    redirect_back fallback_location: root_path, alert: "Could not find content to like."
  rescue ActiveRecord::RecordInvalid
    redirect_back fallback_location: root_path, alert: "Could not update likes."
  end

  private
  # protect random param with whitelist type
  def find_likeable
    case params[:likeable_type]
    when "Character"
      Character.find(params[:likeable_id])
    when "Guide"
      Guide.find(params[:likeable_id])
    when "Topic"
      Topic.find(params[:likeable_id])
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end