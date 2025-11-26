class Admin::DashboardController < Admin::BaseController

  def index
    @users_count = User.count
    @topics_count = Topic.count
    @posts_count = Post.count
  end

end
