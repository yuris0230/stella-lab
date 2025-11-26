class Admin::MembersController < Admin::BaseController
  before_action :set_member, only: [:show, :edit, :update]

  # GET /admin/members
  # List all members (both active / withdrawn)
  def index
    @members = User.includes(:user_profile).order(created_at: :asc)
  end

  # GET /admin/members/:id
  # Show profile and recent activity of one member
  def show
    @profile = @member.user_profile

    @topics = @member.topics.order(created_at: :desc).limit(10)
    @posts  = @member.posts.includes(:topic).order(created_at: :desc).limit(10)
  end

  # GET /admin/members/:id/edit
  # Admin can change member status (active / withdrawn)
  def edit
    @profile = @member.user_profile
  end

  # PATCH /admin/members/:id
  def update
    status_value = params.dig(:user, :status)

    if @member.has_attribute?(:is_active) && status_value.present?
      @member.is_active = (status_value == "active")
    end

    if @member.save
      redirect_to admin_member_path(@member), notice: "Member status has been updated."
    else
      flash.now[:alert] = "Failed to update member."
      @profile = @member.user_profile
      render :edit
    end
  end

  private

  def set_member
    @member = User.find(params[:id])
  end
end