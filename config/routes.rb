Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  
 
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'home', to: 'static_pages#show'
  get 'dashboard', to: 'dashboard#show', as: 'dashboard'

  root to: "static_pages#show"


  resources :moves
  resources :games do
    member do
      patch :join
    end
  end
    resources :pieces, only: %i[show edit update]
end
