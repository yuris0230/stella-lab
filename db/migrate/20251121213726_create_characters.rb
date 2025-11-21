class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.string  :name,  null: false
      t.string  :slug,  null: false
      t.integer :rarity, null: false, default: 0 # 0: SSR, 1: SR
      t.integer :element, null: false, default: 0 # 0: 火, 1: 水, ...
      t.integer :weapon_type, null: false, default: 0 # 0: 短距離, 1: 遠距離
      t.integer :job, null: false, default: 0 # 0: アタッカー, 1: サブ, 2: サポート
      t.text    :summary
      t.date    :released_on
      t.boolean :is_published, null: false, default: false

      t.timestamps
    end

    add_index :characters, :slug, unique: true
  end
end