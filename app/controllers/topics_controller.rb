class TopicsController < ApplicationController
  # Only logged-in users can create topics
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_topic, only: [:show]
  before_action :set_topicable, only: [:new, :create]

  # List of all topics
  def index
    # Includes creator to avoid N+1 queries
    @topics = Topic.includes(:creator, :topicable).ordered
  end

  # Single topic with posts
  def show
    @posts = @topic.posts.includes(:user).order(created_at: :asc)
    @new_post = @topic.posts.build
  end

  # Form for new topic
  def new
    @topic = Topic.new
  end

  # Create topic + first post in one go
  def create
    @topic = Topic.new(topic_params)
    @topic.creator   = current_user
    @topic.topicable = @topicable

    first_body = params[:topic][:first_post_body]

    ActiveRecord::Base.transaction do
      @topic.save!
      @topic.posts.create!(user: current_user, body: first_body)
    end

    redirect_to topic_path(@topic), notice: "Topic was created successfully."
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = "Could not create topic. Please check the form."
    render :new
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end

  def set_topicable
    if params[:character_id].present?
      @topicable = Character.find(params[:character_id])
    elsif params[:item_id].present?
      @topicable = Item.find(params[:item_id])
    else
      redirect_to topics_path, alert: "Please open a character or item page to start a topic."
    end
  end
  # For new topic we receive both title and first_body
  def topic_params
    params.require(:topic).permit(:title)
  end
end