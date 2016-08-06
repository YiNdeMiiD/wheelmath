class MathController < ApplicationController

  def handler
    lat  = params[:lat].to_i  || 0
    long = params[:long].to_i || 0
    start_lat  = 0.0
    start_long = 0.0
    dist = Math.sqrt((lat - start_lat).abs**2+(long-start_long).abs**2)
    eta  = dist*1.5
    @responce_data = { distance: dist, eta: eta }
    respond_to do |format|
      format.html  { render nothing: true, status: 200 }
      format.json  { render json: @responce_data.to_json }
    end
  end

end
