class ItemByStop < ApplicationRecord
  belongs_to :stop
  belongs_to :plan_item
end
