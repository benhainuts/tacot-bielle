class AddPowerToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :horsepower, :integer
  end
end
