class PlanItemsController < ApplicationController
  # skip_before_action :authenticate_user!
  before_action :set_car
  before_action :set_plan_item, only: [:show, :edit, :update]

  def index
    @plan_items =  @car.plan_items.all
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
    @item_by_stops = ItemByStop.where(plan_item_id: @plan_item.id)

    respond_to do |format|
      format.html
      format.ics do
        render plain: @plan_item.generate_ics
      end
    end
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

#   def generate_ics
#     cal = Icalendar::Calendar.new
#     filename = "Prendre RDV pour #{@plan_item.name} de la #{@car.full_name}"

#     if params[:format] == 'vcs'
#       cal.prodid = '-//Microsoft Corporation//Outlook MIMEDIR//EN'
#       cal.version = '1.0'
#       filename += '.vcs'
#     else # ical
#       cal.prodid = '-//Acme Widgets, Inc.//NONSGML ExportToCalendar//EN'
#       cal.version = '2.0'
#       filename += '.ics'
#     end

#     cal.event do |e|
#       e.dtstart     = Icalendar::Values::DateTime.new((@plan_item.next_date_milestone - 45).to_datetime, tzid: Time.zone.name)
#       e.dtend       = Icalendar::Values::DateTime.new(@plan_item.next_date_milestone.to_datetime, tzid: Time.zone.name)
#       e.summary     = "Prendre RDV pour #{@plan_item.name} de la #{@car.full_name}"
#       e.description = "#{@plan_item.name} de la #{@car.full_name} à faire
#                         - avant le #{@plan_item.next_date_milestone}
#                           ou
#                         - avant #{plan_item.next_km_milestone}km"
#       e.url         = nil
#       e.location    = nil
#     end
#   # end

# send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename

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
