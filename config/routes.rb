Rails.application.routes.draw do


  get 'displayflags/driverfuelset'
  get 'dailyresults/create'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'
  
  get 'login', to: 'sessions#new'
  
  post 'login', to: 'sessions#create'
  
  delete 'logout', to: 'sessions#destroy'
  
  get 'adminlogin', to: 'adminsessions#new'
  post 'adminlogin', to: 'adminsessions#create'
  delete 'adminlogout', to: 'adminsessions#destroy'

  
  get 'signup', to: 'users#new'
  

  get  'vehicle_sales/list', to: "vehicle_sales#list"
  

  
  resources :drivers do 
    collection do
      post :update_branch_menus
      
      post :update_truck_menus

    end
    member do
      get :summary
      get :yearlyevaluates
      get :popupcheckitems
      get :checkstatus
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
  
  resources :destinations
  
  
  get  'admin/:number/listdrivers', to: "admin#listdrivers", as: :listdrivers

  resources :admin do 
    
    collection do
      get :truckindex
      get :branchusernew, as: :branchusernew
      post :branchusercreate, as: :branchusercreate
      get :branchuserlist
    end
     member do
       get :branchuseredit
       put :branchuserupdate
       patch :branchuserupdate
     end
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
    get :summary, to: "card_evals#summary", on: :collection

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
  resources :evalparams
  
  post 'driverfuelset', to: "displayflags#driverfuelset"
  patch 'driverfuelset', to: "displayflags#driverfuelchange"
  
  
  resources :reports do
    member do
      post :confirm
    end
  end
end
