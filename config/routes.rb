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
  get 'trader' => 'trader#index'
  patch 'admin/all_users/:id' => 'admin#update', as: 'update_user'

  # resources :users, only: [:edit, :update]
end
