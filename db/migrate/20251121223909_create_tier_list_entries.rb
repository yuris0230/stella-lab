class CreateTierListEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :tier_list_entries do |t|
      t.references :tier_list,  null: false, foreign_key: true
      t.references :character,  null: false, foreign_key: true

      t.integer :tier_rank, null: false # 最強ランキング (数値)
      t.string  :notes # 補足/根拠

      t.timestamps
    end
  end
end