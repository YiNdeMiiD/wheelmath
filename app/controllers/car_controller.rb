class CarController < ApplicationController

  def index
    @cars = Car.all.order(is_free: :desc)
  end

  def add_car
    Car.add_car
    redirect_to cars_path
  end

  def randomize_cars
    Car.randomize
    redirect_to cars_path
  end

end
