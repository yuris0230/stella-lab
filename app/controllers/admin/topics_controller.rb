class Admin::TopicsController < Admin::BaseController
  before_action :set_topic, only: [:show, :hide, :unhide, :destroy]

  # GET /admin/topics
  def index
    # filter: all / characters / items / deleted
    scope = Topic.includes(:topicable, :created_by_user).order(created_at: :desc)

    case params[:filter]
    when "characters"
      @filter = "characters"
      scope = scope.where(topicable_type: "Character")
    when "items"
      @filter = "items"
      scope = scope.where(topicable_type: "Item")
    when "deleted"
      @filter = "deleted"
      if Topic.column_names.include?("is_deleted")
        scope = scope.where(is_deleted: true)
      end
    else
      @filter = "all"
    end

    @topics = scope
  end

  # GET /admin/topics/:id
  def show
    # posts from Post with belongs_to :user
    @posts = @topic.posts.includes(:user).order(:created_at)
  end

  # PATCH /admin/topics/:id/hide
  # hide topic (soft hide, use is_deleted + status + deleted_by_admin_id)
  def hide
    attrs = {}
    attrs[:is_deleted] = true if Topic.column_names.include?("is_deleted")

    if Topic.column_names.include?("status")
      # use enum : open / closed / archived
      attrs[:status] = :archived
    end

    if Topic.column_names.include?("deleted_by_admin_id")
      attrs[:deleted_by_admin_id] = current_admin.id
    end

    @topic.update(attrs)

    redirect_back fallback_location: admin_topics_path,
                  notice: "Topic was hidden."
  end

  # PATCH /admin/topics/:id/unhide
  # unhide topic
  def unhide
    attrs = {}
    attrs[:is_deleted] = false if Topic.column_names.include?("is_deleted")

    if Topic.column_names.include?("status")
      # open
      attrs[:status] = :open
    end

    if Topic.column_names.include?("deleted_by_admin_id")
      attrs[:deleted_by_admin_id] = nil
    end

    @topic.update(attrs)

    redirect_back fallback_location: admin_topics_path,
                  notice: "Topic was unhidden."
  end

  # DELETE /admin/topics/:id
  # soft-delete (use is_deleted + status = archived + deleted_by_admin_id)
  def destroy
    attrs = {}
    attrs[:is_deleted] = true if Topic.column_names.include?("is_deleted")

    if Topic.column_names.include?("status")
      attrs[:status] = :archived
    end

    if Topic.column_names.include?("deleted_by_admin_id")
      attrs[:deleted_by_admin_id] = current_admin.id
    end

    @topic.update(attrs)

    redirect_back fallback_location: admin_topics_path,
                  notice: "Topic was marked as deleted."
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end
end