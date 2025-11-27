class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [:hide, :unhide, :destroy]

  # PATCH /admin/posts/:id/hide
  def hide
    attrs = {}
    attrs[:is_deleted] = true if Post.column_names.include?("is_deleted")
    attrs[:status] = "hidden" if Post.column_names.include?("status")
    attrs[:deleted_by_admin_id] = current_admin.id if Post.column_names.include?("deleted_by_admin_id")

    @post.update(attrs)

    redirect_back fallback_location: admin_topics_path,
                  notice: "Comment was hidden."
  end

  # PATCH /admin/posts/:id/unhide
  def unhide
    attrs = {}
    attrs[:is_deleted] = false if Post.column_names.include?("is_deleted")
    attrs[:status] = "visible" if Post.column_names.include?("status")
    attrs[:deleted_by_admin_id] = nil if Post.column_names.include?("deleted_by_admin_id")

    @post.update(attrs)

    redirect_back fallback_location: admin_topics_path,
                  notice: "Comment was unhidden."
  end

  # DELETE /admin/posts/:id
  # soft delete
  def destroy
    attrs = {}
    attrs[:is_deleted] = true if Post.column_names.include?("is_deleted")
    attrs[:status] = "deleted" if Post.column_names.include?("status")
    attrs[:deleted_by_admin_id] = current_admin.id if Post.column_names.include?("deleted_by_admin_id")

    @post.update(attrs)

    redirect_back fallback_location: admin_topics_path,
                  notice: "Comment was deleted."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end