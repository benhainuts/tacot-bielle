class StopsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update]
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
      if Car.find(@stop.car_id).mileage < @stop.mileage
        Car.find(@stop.car_id).update(mileage: @stop.mileage)
      end
      params.require(:item).keys.each do |item|
        cost = params.require(:itemprice)[item]
        last_stop_item = ItemByStop.where(plan_item_id: item.to_i).last
        plan_item = PlanItem.find(item.to_i)


        if last_stop_item.nil?
          deadline_km_for_this_item = @car.plan_items.find(item.to_i).to_do_every_x_km*(1+@car.last_follow_up_km.div(@car.plan_items.find(item.to_i).to_do_every_x_km))
          deadline_date_for_this_item = @car.last_follow_up_date + @car.plan_items.find(item.to_i).to_do_every_x_years*365*((@car.age_in_days_on(@car.last_follow_up_date)).div(@car.plan_items.find(item.to_i).to_do_every_x_years*365)+1)
        else
          last_stop = Stop.find(last_stop_item.stop_id)
          deadline_km_for_this_item = plan_item.to_do_every_x_km + last_stop.mileage
          deadline_date_for_this_item = last_stop.date + plan_item.to_do_every_x_years*365
        end

        calculated_next_km_milestone = plan_item.to_do_every_x_km + @stop.mileage
        calculated_next_date_milestone = @stop.date + plan_item.to_do_every_x_years*365

        i = ItemByStop.new(stop_id: @stop.id, plan_item_id: item.to_i, item_cost: cost, deadline_km_for_this_item: deadline_km_for_this_item, calculated_next_km_milestone: calculated_next_km_milestone, deadline_date_for_this_item: deadline_date_for_this_item, calculated_next_date_milestone: calculated_next_date_milestone)
        i.save
      end

      redirect_to car_stop_path(@car, @stop), notice: "Passage au garage créé"
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
