class CreateGuides < ActiveRecord::Migration[6.1]
  def change
    create_table :guides do |t|
      t.string  :title, null: false
      t.string  :slug,  null: false
      t.text    :body,  null: false
      t.string  :category, null: false # newbie, system, gacha 等

      t.integer :author_admin_id, null: false # 執筆管理者
      t.boolean :is_published, null: false, default: false

      t.timestamps
    end

    add_index :guides, :slug, unique: true
    add_foreign_key :guides, :admins, column: :author_admin_id
  end
end