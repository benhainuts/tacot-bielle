class PlanItem < ApplicationRecord
  belongs_to :car

  has_many :item_by_stops
end
