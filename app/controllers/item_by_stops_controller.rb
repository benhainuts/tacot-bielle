class ItemByStopsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_stop
  before_action :set_item_by_stop, only: [:show, :edit, :update]

  def index
    @item_by_stops = ItemByStop.all
  end

  def new
    @item_by_stop = @stop.item_by_stops.new
  end

  def create
    @item_by_stop = @stop.item_by_stops.new(item_by_stop_params)
    if @item_by_stop.save
      redirect_to car_stop_path(@stop.car, @stop), notice: "ajouté"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item_by_stop.update(_params)
      redirect_to car_stop_path(@stop.car, @stop), notice: "Passage au garage mis à jour"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

private

  def set_stop
    @stop = Stop.find(params[:stop_id])
  end

  def set_item_by_stop
    @item_by_stop = ItemByStop.find(params[:id])
  end

  def plan_item_params
    params.require(:item_by_stop).permit(:name, :to_do_every_x_km, :to_do_every_x_years)
  end

end
