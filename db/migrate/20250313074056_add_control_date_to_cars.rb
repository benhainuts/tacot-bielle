class AddControlDateToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :control_date, :date
  end
end
