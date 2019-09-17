Rails.application.routes.draw do
  resources :moves
  devise_for :users
  root 'static_pages#index'
  resources :games, only: [:new, :create, :show, :edit, :update]  do
    resources :pieces, only: [:show, :update]
  end
end
