class MembersController < ApplicationController
  # Member list is public (no login required)

  # GET /members
  # Show list of all users with simple stats
  def index
    @members = User.includes(:user_profile).order(created_at: :asc)
  end

  # GET /members/:id
  # Show detail page for one member
  def show
    @member  = User.includes(:user_profile).find(params[:id])
    @profile = @member.user_profile

    # Simple stats
    @topics_count = @member.topics.count
    @posts_count  = @member.posts.count

    # Recent activity (for this member)
    @recent_topics = @member.topics.order(created_at: :desc).limit(5)
    @recent_posts  = @member.posts.includes(:topic).order(created_at: :desc).limit(5)
  end
end