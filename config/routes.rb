Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :games, only: [:create, :show, :update] do
    resources :pieces, only: [:show, :update, :destroy]
  end
end
