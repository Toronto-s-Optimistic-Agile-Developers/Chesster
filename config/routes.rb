<<<<<<< HEAD
Rails.application.routes.draw do
<<<<<<< HEAD
  devise_for :users
  root 'static_pages#index'
  resources :games  do
    resources :pieces, only: [:show, :update, :destroy]
=======
  resources :moves
  devise_for :users
  root 'static_pages#index'
  resources :games  do
    resources :pieces, only: [:show, :edit, :update]
>>>>>>> 6d0cfcb939150325807db57d6c09403f60bc8f89
  end
end
=======
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
    resources :pieces, only: %i[show edit update]
  end
end
>>>>>>> 1284bebaef62edf7c164123120eaba13241d1a65
