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
  
  get  'admin', to: 'admin#new'
  post 'admin', to: 'admin#create'
  delete 'admin', to: 'admin#destroy'

  get  'adminpanel', to: 'admin#index'
  get  'newadmin', to: "admin#newadmin"
  post 'createadmin', to: "admin#createadmin"
  get  'admin_setuser', to: "admin#setuser"
  get  'vehicle_sales/list', to: "vehicle_sales#list"
  
  # get 'drivers/path'
  
  # get 'drivers/destroy'
  
  # get 'vehicle_sales/destroy'
  
  # get 'vehicle_sales/path'
  
  #get 'vehicle_sales/path'
  #get 'vehicle_sales/new', to: 'vehicle_sales#new'
  resources :drivers
  resources :vehicle_sales
  resources :users, only: [:index, :show, :new, :create]
  
  resources :insurances
  resources :highwayfees
  resources :others
  resources :other_cost
  resources :special_cost
  resources :admin
end
