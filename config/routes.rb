Rails.application.routes.draw do
  resources :moves
  devise_for :users
  root 'static_pages#index'
  resources :games  do
    resources :pieces, only: [:show, :edit, :update]
  end
end
