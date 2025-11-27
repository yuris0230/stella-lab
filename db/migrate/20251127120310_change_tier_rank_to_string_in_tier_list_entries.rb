class ChangeTierRankToStringInTierListEntries < ActiveRecord::Migration[6.1]
  def change
    change_column :tier_list_entries, :tier_rank, :string
  end
end