class MathController < ApplicationController

  def handler
    lat  = params[:lat].to_i  || 0
    long = params[:long].to_i || 0
    @three_closets_cars = Car.close_ordered( lat, long ).first(3)
    respond_to do |format|
      format.html  { render nothing: true, status: 200 }
      format.json  { render json: @three_closets_cars.to_json }
    end
  end

end
