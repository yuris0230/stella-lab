class CreateCharacterRecommendedItems < ActiveRecord::Migration[6.1]
  def change
    create_table :character_recommended_items do |t|
      t.references :character, null: false, foreign_key: true
      t.references :item,      null: false, foreign_key: true
      t.string :note

      t.timestamps
    end

    add_index :character_recommended_items,
              [:character_id, :item_id],
              unique: true,
              name: "index_character_recommended_items_unique"
  end
end