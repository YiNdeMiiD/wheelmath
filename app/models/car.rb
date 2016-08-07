class Car < ActiveRecord::Base

  validates :number, presence: true, uniqueness: true

  scope :free_to_ride, -> { where(is_free: true) }

  def self.add_car
    car = new( number: "cr#{rand(1000)}n#{rand(1000)}" )
    car.rand_stats
    car.save!
  end

  def self.randomize
    all.each do |car|
      car.rand_stats
      car.save!
    end
  end
  
  def rand_stats
    self.pos_long = rand()*100
    self.pos_lat  = rand()*100
    self.is_free  = (rand(0..1) == 1 ? true : false)
  end

  def self.close_ordered(lat, long)
    cars_with_distance = {}
    free_to_ride.each do |car|
      distance = Math.sqrt((car.pos_lat - lat).abs**2+(car.pos_long-long).abs**2) 
      arr_time = distance * 1.5 
      cars_with_distance[car.number] = { harvestine_distance: distance, arrival_time: arr_time }
    end
    cars_with_distance.sort { |a, b| a[1][:arrival_time] <=> b[1][:arrival_time] }
  end  

end
