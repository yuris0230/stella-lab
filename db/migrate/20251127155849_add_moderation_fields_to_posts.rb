class AddModerationFieldsToPosts < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:posts, :is_deleted)
      add_column :posts, :is_deleted, :boolean, null: false, default: false
      add_index  :posts, :is_deleted
    end

    unless column_exists?(:posts, :deleted_by_admin_id)
      add_column :posts, :deleted_by_admin_id, :integer
      add_index  :posts, :deleted_by_admin_id
    end
  end
end