class PlanItem < ApplicationRecord
  belongs_to :car

  has_many :item_by_stops

  require 'icalendar'

  def next_km_milestone
    last_stop_item = ItemByStop.where(plan_item_id: id).last

    if last_stop_item.nil?
      if name == "Contrôle technique" && car.date_of_first_purchase < Date.today - 4*365
        deadline_km_for_this_item = car.mileage + (4-car.age_in_days_on(Date.today)/(365))*car.estimated_mileage_per_year
      else
        deadline_km_for_this_item = to_do_every_x_km*(1+Car.find(car_id).last_follow_up_km.div(to_do_every_x_km))
      end
    else
      last_stop = Stop.find(last_stop_item.stop_id)
      deadline_km_for_this_item = to_do_every_x_km + last_stop.mileage
    end
    return deadline_km_for_this_item
  end

  def last_stop_item
    ItemByStop.where(plan_item_id: id).last
  end

  def last_stop
    Stop.find(last_stop_item.stop_id)
  end

  def next_date_milestone
    # last_stop_item = ItemByStop.where(plan_item_id: id).last
    car = Car.find(car_id)

    if last_stop_item.nil?
      if name == "Contrôle technique" && car.date_of_first_purchase < Date.today - 4*365
          deadline_date_for_this_item = car.date_of_first_purchase + 4*365
      else
          deadline_date_for_this_item = car.date_of_first_purchase + to_do_every_x_years*365*((car.age_in_days_on(car.last_follow_up_date)).div(to_do_every_x_years*365)+1)
      end
    else
      # last_stop = Stop.find(last_stop_item.stop_id)
      deadline_date_for_this_item = last_stop.date + to_do_every_x_years*365
      return deadline_date_for_this_item
    end
  end

  def days_to_go
    # last_stop = Stop.find(last_stop_item.stop_id)
    return (next_date_milestone - Date.today).to_i
  end

  def km_to_go
    # last_stop = Stop.find(last_stop_item.stop_id)
    return (next_km_milestone - car.mileage)
  end

  def deadline_status
    case
    when days_to_go > 45 && km_to_go > car.estimated_mileage_per_year/8
      return "ok"
    when days_to_go < 0 || km_to_go < 0
      return "en retard"
    when days_to_go < 14 || km_to_go < car.estimated_mileage_per_year/24
      return "urgent"
    else
      return "à faire"
    end
  end

  def deadline_status_km
    case
    when km_to_go > car.estimated_mileage_per_year/8
      return "ok"
    when km_to_go < 0
      return "en retard"
    when km_to_go < car.estimated_mileage_per_year/24
      return "urgent"
    else
      return "à faire"
    end
  end


  def deadline_status_date
    case
    when days_to_go > 45
      return "ok"
    when days_to_go < 0
      return "en retard"
    when days_to_go < 14
      return "urgent"
    else
      return "à faire"
    end
  end

  def generate_ics
    cal = Icalendar::Calendar.new
    filename = "Prendre RDV pour #{name} de la #{car.full_name}"

    # if params[:format] == 'vcs'
    #   cal.prodid = '-//Microsoft Corporation//Outlook MIMEDIR//EN'
    #   cal.version = '1.0'
    #   filename += '.vcs'
    # else # ical
      # cal.prodid = '-//Acme Widgets, Inc.//NONSGML ExportToCalendar//EN'
      # cal.version = '2.0'
      # filename += '.ics'
    # end

    cal.event do |e|
      e.dtstart     = Icalendar::Values::DateTime.new((next_date_milestone - 45).to_datetime, tzid: Time.zone.name)
      e.dtend       = Icalendar::Values::DateTime.new(next_date_milestone.to_datetime, tzid: Time.zone.name)
      e.summary     = "Prendre RDV pour #{name} de la #{car.full_name}"
      e.description = "#{name} de la #{car.full_name} à faire
                        - avant le #{next_date_milestone}
                          ou
                        - avant #{next_km_milestone}km"
      e.url         = nil
      e.location    = nil
      e.ip_class = "PRIVATE"
    end
    cal.publish
    cal.to_ical
    # cal.send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
  end

end
