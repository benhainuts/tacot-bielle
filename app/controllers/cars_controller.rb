class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update]
  before_action :set_car, only: [:edit, :update, :show]

  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    if @car.save

      # create_maintenance(@car)
      redirect_to car_path(@car)

    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @plan_items = @car.plan_items
  end

  def edit
  end

  def update
    if @car.update(car_params)
      redirect_to car_path(@car)
    else
      render :new, status: :unprocessable_entity
    end
  end

private

def car_params

  params.require(:car).permit(:make, :model, :mileage, :date_of_first_purchase, :estimated_mileage_per_year, :engine, :fuel, :horsepower, :maintenance_status, :last_follow_up_km, :last_follow_up_date, :photo)

end

def set_car
  @car = Car.find(params[:id])
end

def create_maintenance(car)

  client = OpenAI::Client.new
  chatgpt_response = client.chat(parameters: {
    model: "gpt-4o-mini",
    messages: [{ role: "user", content:
  "une voiture marque #{car.make} Modele #{car.model} #{car.engine} #{car.fuel} #{car.horsepower} de #{car.date_of_first_purchase} avec #{car.mileage} km et climatisation et faisant #{car.estimated_mileage_per_year}. liste moi dans un array de hash chaque entretien a faire selon le constructeur avec son nom dans name: sa périodicité en km dans to_do_every_x_km: et sa periodicite en année dans to_do_every_x_years. ne renvoie que cet array"}]
  })
  content = chatgpt_response["choices"][0]["message"]["content"]

  content.each do |ligne|
    PlanItem.create(car: car, name: ligne[:name], to_do_every_x_km: ligne[:to_do_every_x_km], to_do_every_x_years: ligne[:to_do_every_x_years])
  end
end

end
