Rails.application.routes.draw do
  
  root to: 'car#index'
  get 'cars',               to: 'car#index'
  post 'car/add_car',        to: 'car#add_car'
  post 'car/randomize_cars', to: 'car#randomize_cars'
  
  get 'eta', to: 'math#handler'

end
