class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :display_name, null: false
      t.text :bio
      t.boolean :is_public, null: false, default: true

      t.timestamps
    end
  end
end
