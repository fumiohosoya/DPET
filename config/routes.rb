Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  
  post 'login', to: 'sessions#create'
  
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  

  get  'vehicle_sales/list', to: "vehicle_sales#list"
  

  
  resources :drivers do 
    collection do
      post :update_branch_menus
      
      post :update_truck_menus

    end
  end
  
  
  resources :vehicle_sales
  resources :users, only: [:index, :show, :new, :create]
  
  resources :trucks
  resources :insurances
  resources :highwayfees
  resources :others
  resources :other_cost
  resources :special_cost
  
  
  get  'admin/:number/listdrivers', to: "admin#listdrivers", as: :listdrivers

  resources :admin do 
    
    collection do
      get :truckindex
    end
    
    # member do
    #   get :listdrivers
      
    # end
  end
  
  resources :batteries
  resources :meters
  resources :brakes
  resources :lamp_stopper_tires
  resources :greaseups
  resources :engine_oils
  resources :air_reservers
  resources :tires
  resources :oil_tanks
  resources :cabups
  resources :greaseups
  
  get 'driverlogin',  to: 'driversessions#new'
  post 'driverlogin', to: 'driversessions#create'

  get 'topmenu/:id',  to: 'drivers#topmenu', as: :topmenu

  get  'adminpanel', to: 'admin#index'
  get  'newadmin', to: "admin#newadmin"
  post 'createadmin', to: "admin#createadmin"
  get  'admin_setuser', to: "admin#setuser"
end
