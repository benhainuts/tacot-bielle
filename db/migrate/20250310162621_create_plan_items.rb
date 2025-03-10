class CreatePlanItems < ActiveRecord::Migration[7.1]
  def change
    create_table :plan_items do |t|
      t.string :name
      t.integer :to_do_every_x_km
      t.integer :to_do_every_x_years
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
