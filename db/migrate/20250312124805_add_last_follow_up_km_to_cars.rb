class AddLastFollowUpKmToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :last_follow_up_km, :integer
  end
end
