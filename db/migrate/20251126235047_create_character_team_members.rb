class CreateCharacterTeamMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :character_team_members do |t|
      t.references :character, null: false, foreign_key: true
      t.references :teammate,  null: false, foreign_key: { to_table: :characters }
      t.string :note

      t.timestamps
    end

    add_index :character_team_members,
              [:character_id, :teammate_id],
              unique: true,
              name: "index_character_team_members_unique"
  end
end