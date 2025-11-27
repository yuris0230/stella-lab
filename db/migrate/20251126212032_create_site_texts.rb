class CreateSiteTexts < ActiveRecord::Migration[6.1]
  def change
    create_table :site_texts do |t|
      t.string :key, null: false # unique key, e.g. "home_game_info" / "about_body"
      t.string :title # optional title for a section
      t.text :body # main HTML/text body

      t.timestamps
    end

    add_index :site_texts, :key, unique: true
  end
end