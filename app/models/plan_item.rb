class PlanItem < ApplicationRecord
  belongs_to :car

  has_many :item_by_stops

  def next_km_milestone
    last_stop_item = ItemByStop.where(plan_item_id: id).last

    if last_stop_item.nil?
      deadline_km_for_this_item = to_do_every_x_km*(1+Car.find(car_id).last_follow_up_km.div(to_do_every_x_km))
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
      deadline_date_for_this_item = car.date_of_first_purchase + to_do_every_x_years*365*((car.age_in_days_on(car.last_follow_up_date)).div(to_do_every_x_years*365)+1)
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
    when days_to_go > 45 && km_to_go > car.estimated_mileage_per_year/1.5
      return "ok"
    when days_to_go < 0 || km_to_go < 0
      return "LATE"
    when days_to_go < 14 || km_to_go < car.estimated_mileage_per_year/24
      return "URGENT"
    else
      return "TO DO"
    end
  end

end
