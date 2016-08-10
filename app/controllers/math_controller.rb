class MathController < ApplicationController

  def handler
    lat  = params[:lat].to_i  || 50
    long = params[:long].to_i || 50
    #так как для моделирования я взял диапазон координат lat(0, 100) и long(0, 100), 
    #то в случае отсутствия параметров я беру середину поля
    avalable_cars_ordered = Car.close_ordered(lat, long)
    car_namber           = avalable_cars_ordered.first[0]
    distance             = avalable_cars_ordered.first[1][:harvestine_distance]
    eta                  = calculate_eta(avalable_cars_ordered)
    responce_data        = { car_number: car_namber, distance: distance, eta: eta }
    respond_to do |format|
      format.html  { render nothing: true, status: 200 }
      format.json  { render json: responce_data.to_json }
    end
  end

end
