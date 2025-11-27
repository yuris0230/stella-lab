class AddModerationFieldsToTopics < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :is_deleted, :boolean, null: false, default: false
    add_column :topics, :deleted_by_admin_id, :integer

    add_index :topics, :is_deleted
    add_index :topics, :deleted_by_admin_id
  end
end