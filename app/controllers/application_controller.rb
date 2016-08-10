class ApplicationController < ActionController::Base
 
  def calculate_eta(available_cars)
    eta = available_cars.first(3).map{ |car| car[1][:arrival_time] }.inject{ |a, b| a + b }/3
    to_minutes(eta)
  end

  def to_minutes(value)
    time_diff = Time.now - (value).minutes.ago
    Time.at(time_diff.round.abs).utc.strftime "%H:%M:%S"
  end

end
