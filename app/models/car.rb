class Car < ApplicationRecord
  belongs_to :user
  has_many :stops
  has_many :plan_items
  has_many :items_by_stops, through: :stops

  # has_one_attached :photo

  validates :model, presence: true, uniqueness: { scope: [:make, :date_of_first_purchase, :user],
    message: "your car is already declared" }
  validates :make, presence: true
  validates :mileage, presence: true
  validates :date_of_first_purchase, presence: true
  validates :estimated_mileage_per_year, presence: true


  def full_name
    "#{make} #{model}"
  end
end
