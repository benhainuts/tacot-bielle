class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.integer :mileage
      t.date :date_of_first_purchase
      t.integer :estimated_mileage_per_year
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
