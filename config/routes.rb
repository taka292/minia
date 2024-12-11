Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  # devise_for :users
  get "home/index"
  root "home#index"
  # resources :reviews
  resources :reviews, only: [:index, :new, :create]
  # get 'search', to: 'reviews#search'
end
