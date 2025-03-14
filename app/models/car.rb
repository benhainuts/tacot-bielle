class Car < ApplicationRecord
  belongs_to :user
  has_many :stops
  has_many :plan_items
  has_many :item_by_stops, through: :stops

  has_one_attached :photo

  ENERGIE = %w[Essence Diesel Hybride Hybride-diesel Electrique Hydrogene GPL].freeze

  validates :model, presence: true, uniqueness: { scope: [:make, :date_of_first_purchase, :user],
   message: "votre voiture est déjà déclarée" }
  validates :make, presence: true
  validates :mileage, presence: true
  validates :date_of_first_purchase, presence: true
  validates :estimated_mileage_per_year, presence: true
  validates :fuel, inclusion: { in: ENERGIE }
  validates :engine, format: { with: /\A\d+([.,]\d{1,2})?\z/, message: "doit être un nombre avec max 2 décimales (ex: 10.1 ou 10,1)"}


  def full_name
    "#{make} #{model}"
  end

  def age_in_days_on(date)
    (Date.parse(date.to_s) - Date.parse(date_of_first_purchase.to_s)).to_i
  end
end
