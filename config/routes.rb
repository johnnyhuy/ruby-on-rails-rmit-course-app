Rails.application.routes.draw do
  # User handling
  get    'register', to: 'users#new'
  get    'login',    to: 'sessions#new'
  post   'login',    to: 'sessions#create'
  delete 'logout',   to: 'sessions#destroy'

  # Resourceful routes
  # Follows the RESTful API
  resources :categories
  resources :locations
  resources :courses
  resources :users, except: [:new]

  # Root home template
  root 'home#index'
end
