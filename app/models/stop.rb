class Stop < ApplicationRecord
  belongs_to :car

  has_many :item_by_stops

  # has_one_attached :photo
end
