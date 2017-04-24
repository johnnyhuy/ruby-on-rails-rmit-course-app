Rails.application.routes.draw do
  get 'register',   to: 'users#new'
  get 'sessions/new'

  resources :courses

  root 'home#index'
end
