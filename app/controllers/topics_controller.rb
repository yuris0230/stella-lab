class TopicsController < ApplicationController
  # Only logged-in users can create topics
  before_action :authenticate_user!, only: [:new, :create]

  # List of all topics
  def index
    # Includes creator to avoid N+1 queries
    @topics = Topic.includes(:creator).ordered
  end

  # Single topic with posts
  def show
    @topic = Topic.includes(posts: :user).find(params[:id])
    @posts = @topic.posts.visible.order(:created_at)
    @post  = Post.new # used by the reply form
  end

  # Form for new topic
  def new
    @topic = Topic.new
    # Store first post body in a separate instance variable for the form
    @topic_first_body = ''
  end

  # Create topic + first post in one go
  def create
    @topic = Topic.new(topic_params.except(:first_body))
    @topic.creator = current_user
    @topic.status  = :open

    first_body = topic_params[:first_body].to_s

    if first_body.blank?
      @topic.errors.add(:base, 'First post cannot be blank.')
      @topic_first_body = ''
      render :new and return
    end

    ActiveRecord::Base.transaction do
      @topic.save!
      @topic.posts.create!(user: current_user, body: first_body)
    end

    redirect_to @topic, notice: 'Topic was created.'
  rescue ActiveRecord::RecordInvalid
    @topic_first_body = first_body
    render :new
  end

  private

  # For new topic we receive both title and first_body
  def topic_params
    params.require(:topic).permit(:title, :first_body)
  end
end