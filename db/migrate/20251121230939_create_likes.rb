class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.string  :likeable_type, null: false
      t.bigint  :likeable_id,   null: false

      t.timestamps
    end

    add_index :likes, [:user_id, :likeable_type, :likeable_id],
              unique: true, name: "index_likes_on_user_and_likeable"
  end
end