Rails.application.routes.draw do
  get 'trucks/create'
  get 'trucks/destroy'
  get 'truckrelations/create'
  get 'truckrelations/destroy'
  get 'displayflags/driverfuelset'
  get 'dailyresults/create'
  get 'ext2s/new'
  get 'ext2s/create'
  get 'ext2s/edit'
  get 'ext2s/update'
  get 'ext2s/destroy'
  get 'ext1s/new'
  get 'ext1s/create'
  get 'ext1s/edit'
  get 'ext1s/update'
  get 'ext1s/destroy'
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
    member do
      get :evaluates
      get :yearlyevaluates
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
  resources :checkschedules do
    member do
      get :make_default
      get :makeext1
      get :makeext2
    end
    collection do
       get :newschedule
    end
  end
  
  resources :ext1s
  resources :ext2s
  
  resources :card_evals do
    get :checkresult, to: "card_evals#listresults", on: :collection
    get :drivereval, to: "card_evals#drivereval", on: :collection
    collection do
      get :check
      post :checkresult
    end
  end
  
  
  get 'driverlogin',  to: 'driversessions#new'
  post 'driverlogin', to: 'driversessions#create'

  get 'topmenu/:id',  to: 'drivers#topmenu', as: :topmenu

  get  'adminpanel', to: 'admin#index'
  get  'newadmin', to: "admin#newadmin"
  post 'createadmin', to: "admin#createadmin"
  get  'admin_setuser', to: "admin#setuser"
  
  get 'readevals', to: "readevals#index", as: :readevals
    
  resources :trucks, only:[:new, :create, :destroy]
  resources :dailyresults, only:[:create]
  resources :mileageproofs, only:[:create]
  resources :truckrelations, only:[:create, :destroy]
  
  resources :fueltargets
  
  post 'driverfuelset', to: "displayflags#driverfuelset"
  patch 'driverfuelset', to: "displayflags#driverfuelchange"
end
