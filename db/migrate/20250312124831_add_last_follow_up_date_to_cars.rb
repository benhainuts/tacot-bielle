class AddLastFollowUpDateToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :last_follow_up_date, :date
  end
end
