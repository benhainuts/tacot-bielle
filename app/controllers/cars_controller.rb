class CarsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update]
  before_action :set_car, only: [:edit, :update, :show, :call_maintenance]

  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    @car.make = @car.make.upcase()
    @car.model = @car.model.capitalize()
    # raise
    if @car.save
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

  def add_plan
    create_maintenance(@car)
  end

  def update
    if @car.update(car_params)
      redirect_to car_path(@car)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def call_maintenance
    create_maintenance(@car)
    create_control(@car)
    redirect_to car_alerts_path(@car)
      # Logic for handling GET requests
  end

  def details
    @car = Car.find(params[:id])
  end

private

def car_params
  params.require(:car).permit(:make, :model, :mileage, :date_of_first_purchase, :estimated_mileage_per_year, :engine, :fuel, :horsepower, :maintenance_status, :last_follow_up_km, :last_follow_up_date, :photo)
  # :control_date, :maintenance_status
end

def set_car
  @car = Car.find(params[:id])
end

def create_maintenance(car)

  client = OpenAI::Client.new
  chatgpt_response = client.chat(parameters: {
    model: "gpt-4o-mini",

    messages: [{ role: "user", content:
  "une voiture de marque #{car.make} Modele #{car.model} moteur #{car.engine} carburant #{car.fuel} puissance #{car.horsepower} de #{car.date_of_first_purchase} avec #{car.mileage} km et faisant #{car.estimated_mileage_per_year} km par an.  liste moi dans un json chaque entretien a faire, avec au minimum si applicable (vidange huile/ filtre à air / filtre carburant / filtre d'habitable / courroie de distribution / liquide de frein / liquide de refroidissement / révision), avec des intitulés courts ( 30 caracteres max) selon le constructeur avec son nom dans name: sa périodicité en km dans to_do_every_x_km: et sa periodicite en année dans to_do_every_x_years. ne renvoie que ce json, si erreur renvoie ce json vide."}]
  })
  content = chatgpt_response["choices"][0]["message"]["content"]
  g = content.gsub('```','')
  c= g.gsub("json\n","")
  h = JSON.parse(c,symbolize_names: true)

  h.each do |ligne|
    PlanItem.create(car: car, name: ligne[:name], to_do_every_x_km: ligne[:to_do_every_x_km], to_do_every_x_years: ligne[:to_do_every_x_years])
  end
end

def create_control(car)
    PlanItem.create(car: car, name: "Contrôle technique", to_do_every_x_km: car.estimated_mileage_per_year*2, to_do_every_x_years: 2)
end

end
