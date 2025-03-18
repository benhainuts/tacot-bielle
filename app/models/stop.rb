class Stop < ApplicationRecord
  belongs_to :car

  has_many :item_by_stops

  validates :date, presence: true
  validates :mileage, presence: true

  has_many_attached :photos
end
