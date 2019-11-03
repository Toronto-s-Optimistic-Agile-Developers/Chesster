Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  mount ActionCable.server => '/cable'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'home', to: 'static_pages#show'
  get 'dashboard', to: 'dashboard#show', as: 'dashboard'
  get 'privacy', to: 'static_pages#privacy'

  root to: "static_pages#show"

  resources :moves
  resources :games do
    member do
      patch :join
      patch :forfeit
      patch :left_white_castle
    end
  end

  resources :pieces

end
