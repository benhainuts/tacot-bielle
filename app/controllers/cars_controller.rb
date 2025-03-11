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
      redirect_to cars_path
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
  params.require(:car).permit(:make, :model, :mileage, :date_of_first_purchase, :estimated_mileage_per_year)
end

def set_car
  @car = Car.find(params[:id])
end

end
