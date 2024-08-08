Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # Define a route that maps to a controller action
  root 'home#index'

  get 'admin/all_users', to: 'admin#all_users', as: 'admin_all_users'
  get 'admin/all_users/:id/edit' => 'admin#edit', as: 'edit_user'
  get 'admin/show/:id' => 'admin#show', as: 'show_user'
  get '/home' => 'trader#index'
  patch 'admin/all_users/:id' => 'admin#update', as: 'update_user'
  patch 'approve_user/:id', to: 'admin#approve_user', as: 'approve_user'

  get 'admin/new', to: 'admin#new', as: 'new_admin'
  post 'admin/create', to: 'admin#create', as: 'create_admin'

  get '/home/stockmarket' => 'stock_market#index'
  post 'home/myportfolio/:id' => 'stock_market#add', as: 'add_stock'
  get 'home/myportfolio' => 'my_portfolio#my_stocks'
  delete 'home/myportfolio/:id' => 'my_portfolio#delete', as: 'delete_stock'


  resources :users
end
