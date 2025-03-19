class AddNotesToStops < ActiveRecord::Migration[7.1]
  def change
    add_column :stops, :notes, :text
  end
end
