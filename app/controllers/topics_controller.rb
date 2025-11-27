class TopicsController < ApplicationController
  # Only logged-in users can create topics
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_topic,    only: [:show]
  before_action :set_topicable, only: [:new, :create]

  # List of all topics
  def index
    # if no delete + include creator prot N+1
    @topics = Topic.not_deleted
                   .includes(:created_by_user)
                   .ordered
  end

  # Single topic with posts
  def show
    # use @topic from set_topic
    @posts = @topic.posts.not_deleted.order(:created_at)
    @post  = @topic.posts.build
  end

  # Form for new topic
  def new
    @topic = Topic.new
  end

  # Create topic + first post in one go
  def create
    @topic = Topic.new(topic_params)
    @topic.created_by_user = current_user
    @topic.topicable       = @topicable

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
    # if is_deleted use scope not_deleted
    @topic = Topic.not_deleted.find(params[:id])
  end

  def set_topicable
    if params[:character_id].present?
      @topicable = find_topicable(Character, params[:character_id])
    elsif params[:item_id].present?
      @topicable = find_topicable(Item, params[:item_id])
    else
      redirect_to topics_path,
                  alert: "Please open a character or item page to start a topic."
    end
  end

  # id and slug
  def find_topicable(klass, identifier)
    if klass.column_names.include?("slug")
      klass.find_by!(slug: identifier)
    else
      klass.find(identifier)
    end
  end

  # For new topic we receive both title and first_body
  def topic_params
    params.require(:topic).permit(:title)
  end
end