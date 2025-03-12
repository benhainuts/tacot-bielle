class AddFuelToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :fuel, :string
  end
end
