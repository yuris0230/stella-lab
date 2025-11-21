class CreateTierLists < ActiveRecord::Migration[6.1]
  def change
    create_table :tier_lists do |t|
      t.string  :title, null: false
      t.boolean :is_published, null: false, default: false

      t.timestamps
    end
  end
end