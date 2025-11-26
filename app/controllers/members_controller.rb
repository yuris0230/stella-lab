class MembersController < ApplicationController
  # Member list is public (no login required)

  # GET /members
  def index
    # Show only active users if is_active column exists
    scope = User.includes(:user_profile).order(created_at: :asc)
    scope = scope.where(is_active: true) if User.new.has_attribute?(:is_active)
    @members = scope
  end

  # GET /members/:id
  def show
    @member = User.includes(:user_profile).find(params[:id])

    if @member.has_attribute?(:is_active) && !@member.is_active?
      redirect_to members_path, alert: "This user is inactive." and return
    end

    @profile = @member.user_profile

    # Simple stats
    @topics_count = @member.topics.count
    @posts_count  = @member.posts.count

    # Recent activity of this member
    @recent_topics = @member.topics.order(created_at: :desc).limit(5)
    @recent_posts  = @member.posts.includes(:topic).order(created_at: :desc).limit(5)
  end
end