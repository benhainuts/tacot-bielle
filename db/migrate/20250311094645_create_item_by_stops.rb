class CreateItemByStops < ActiveRecord::Migration[7.1]
  def change
    create_table :item_by_stops do |t|
      t.references :stop, null: false, foreign_key: true
      t.references :plan_item, null: false, foreign_key: true
      t.float :item_cost
      t.integer :deadline_km_for_this_item
      t.integer :calculated_next_km_milestone
      t.date :deadline_date_for_this_item
      t.date :calculated_next_date_milestone

      t.timestamps
    end
  end
end
