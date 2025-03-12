class PlanItemsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_car
  before_action :set_plan_item, only: [:show, :edit, :update]

  def index
    @plan_items = PlanItem.all
  end

  def new
    @plan_item = @car.plan_items.new
  end

  def create
    @plan_item = @car.plan_items.new(plan_item_params)
    if @plan_item.save
      redirect_to car_path(@car), notice: "Plan d'entretien mis à jour"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @plan_item.update(plan_item_params)
      redirect_to car_path(@car), notice: "Plan d'entretien mis à jour"
    else
      render car_path(@car), status: :unprocessable_entity
    end
  end

  def destroy
  end

  # def next_km_milestone
  #   last_stop_item = ItemByStop.where(plan_item_id: @plan_item.id).last

  #   if last_stop_item.nil?
  #     deadline_km_for_this_item = @plan_item.to_do_every_x_km*(1+@car.last_follow_up_km.div(@plan_item.to_do_every_x_km))
  #   else
  #     last_stop = Stop.find(last_stop_item.stop_id)
  #     deadline_km_for_this_item = @plan_item.to_do_every_x_km + @car.mileage
  #   end
  #   return deadline_km_for_this_item
  # end

private

def set_car
  @car = Car.find(params[:car_id])
end

def set_plan_item
  @plan_item = PlanItem.find(params[:id])
end

def plan_item_params
  params.require(:plan_item).permit(:name, :to_do_every_x_km, :to_do_every_x_years)
end

end
