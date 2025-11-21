class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string  :topicable_type, null: false
      t.bigint  :topicable_id,   null: false

      t.string  :title, null: false
      t.integer :status, null: false, default: 0 # 0: open, 1: closed

      t.integer :created_by_user_id, null: false # FK to users
      t.boolean :pinned, null: false, default: false # admin用
      t.boolean :locked, null: false, default: false # admin用

      t.timestamps
    end

    add_index :topics, [:topicable_type, :topicable_id]
    add_foreign_key :topics, :users, column: :created_by_user_id
  end
end
