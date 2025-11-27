class PostsController < ApplicationController
  # Only logged-in users can post replies
  before_action :authenticate_user!, only: [:create]

  # Create a new reply to a topic
  def create
    # cant if topic is delete
    @topic = Topic.not_deleted.find(params[:topic_id])
    @post  = @topic.posts.build(post_params)
    @post.user = current_user

    # Prevent posting to locked/closed topics
    if @topic.locked? || @topic.status_closed?
      redirect_to @topic, alert: 'This topic is locked.' and return
    end

    if @post.save
      redirect_to @topic, notice: 'Your reply has been posted.'
    else
      # render only not_deleted
      @posts = @topic.posts.not_deleted.order(:created_at)
      render 'topics/show'
    end
  end

  # Simple "Latest posts" list for the sidebar link
  def latest
    @posts = Post.not_deleted
                 .includes(:topic, :user)
                 .order(created_at: :desc)
                 .limit(20)
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end