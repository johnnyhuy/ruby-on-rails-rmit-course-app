Rails.application.routes.draw do
  get 'register',   to: 'users#new'
  get 'sessions/new'

  resources :courses
  resources :users, except: [:new]

  root 'home#index'
end
