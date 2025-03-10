class CreateStops < ActiveRecord::Migration[7.1]
  def change
    create_table :stops do |t|
      t.date :date
      t.string :garage
      t.float :cost
      t.integer :mileage
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
