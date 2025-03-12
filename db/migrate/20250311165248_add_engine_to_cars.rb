class AddEngineToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :engine, :string
  end
end
