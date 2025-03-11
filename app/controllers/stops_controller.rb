class StopsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update]
  before_action :set_car
  before_action :set_stop, only: [:show, :edit, :update]


  def index
    @stop = Stop.all
  end

  def show

  end

  def new
    @stop = @car.stops.new
  end

  def create
    @stop = @car.stops.new(stop_params)
    if @stop.save
      redirect_to car_path(@car), notice: "Passage au garage créé"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @stop.update(stop_params)
      redirect_to car_path(@car), notice: "Passage au garage mis à jour"
    else
      render car_path(@car), status: :unprocessable_entity
    end
  end

  private

def set_car
  @car = Car.find(params[:car_id])
end

def set_stop
  @stop = Stop.find(params[:id])
end

def stop_params
  params.require(:stop).permit(:date, :garage, :cost, :mileage)
end
end
