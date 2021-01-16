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
  
  # get 'drivers/path'
  
  # get 'drivers/destroy'
  
  # get 'vehicle_sales/destroy'
  
  # get 'vehicle_sales/path'
  
  #get 'vehicle_sales/path'
  #get 'vehicle_sales/new', to: 'vehicle_sales#new'
  resources :drivers
  resources :vehicle_sales
  resources :users, only: [:index, :show, :new, :create]
end
