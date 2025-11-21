class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :slug
      t.integer :rarity
      t.integer :item_type
      t.text :summary
      t.date :released_on
      t.boolean :is_published

      t.timestamps
    end
  end
end
