class AddMaintenanceStatusToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :maintenance_status, :string
  end
end
