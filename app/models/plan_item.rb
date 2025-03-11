class PlanItem < ApplicationRecord
  belongs_to :car

  has_many :items_by_stops
end
