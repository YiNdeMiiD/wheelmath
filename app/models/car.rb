class Car < ActiveRecord::Base 

  validates :number,   presence: true, uniqueness: true
  validates :is_free,  inclusion: { in: [true, false] }
  validates :pos_lat,  presence: true
  validates :pos_long, presence: true

  scope :free_to_ride, -> { where(is_free: true) }

  def self.create_pack_of_cars
    (20 - Car.count).times { Car.add_car } if Car.count < 20 
  end

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
    #для моделирования я использую условное поле 100 на 100, где располагаются машины в случаных местах 
    #и случайным образом получают статус свободно/занято 
    self.pos_long = rand()*100
    self.pos_lat  = rand()*100
    self.is_free  = (rand(0..1) == 1 ? true : false)
  end

  def self.close_ordered(lat, long)
    cars_with_distance = {}
    free_to_ride.each do |car|
      distance = Math.sqrt((car.pos_lat - lat).abs**2+(car.pos_long-long).abs**2)
      #для простоты модели я использую расчёт расстояния между точками по прямой, 
      #следуя старой доброй традиции моделирования жидкого сферического коня в вакууме. 
      arrival_time = distance * 1.5
      #следуя условиям задачи время считается как дистанция * 1.5, для удобства и простоты логики 
      #я перевёл полученное время в минуты( например 12.534 = 12 минут 32 секунды ) 
      cars_with_distance[car.number] = { harvestine_distance: distance, arrival_time: arrival_time }
    end
    cars_with_distance.sort { |a, b| a[1][:arrival_time] <=> b[1][:arrival_time] }
  end  

end
