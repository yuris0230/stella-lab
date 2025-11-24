class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :topic, null: false, foreign_key: true # topic_id
      t.references :user,  null: false, foreign_key: true # user_id（投稿ユーザー）

      t.string  :guest_name # ゲスト表示名（ログインなし投稿なら）
      t.text    :body, null: false # 本文

      t.boolean :is_deleted, null: false, default: false # 論理削除フラグ
      t.bigint :deleted_by_admin_id # 管理者削除時のAdmin ID

      t.timestamps
    end

    add_foreign_key :posts, :admins, column: :deleted_by_admin_id
  end
end