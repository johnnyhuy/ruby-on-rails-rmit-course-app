Rails.application.routes.draw do
  # User handling
  get    'register', to: 'users#new'
  get    'login',    to: 'sessions#new'
  post   'login',    to: 'sessions#create'
  delete 'logout',   to: 'sessions#destroy'

  post   'courses/:id/like',     to: 'likes#new', as: 'like'
  post   'courses/:id/dislike',  to: 'dislikes#new', as: 'dislike'

  # Resourceful routes
  # Follows the RESTful API
  resources :categories
  resources :locations
  resources :courses
  resources :users, except: [:new]

  # Root home template
  root 'home#index'
end
