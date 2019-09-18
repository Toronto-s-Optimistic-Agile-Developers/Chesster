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
