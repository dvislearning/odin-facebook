Rails.application.routes.draw do
  get 'posts', to: 'posts#index'
  get 'static_pages/new'
  root 'posts#index'  
  devise_for :users
  get '/pending', to: 'users#pending'
  resources :users, only: [:show, :index, :update]
  resources :relationships, only: [:create, :update, :destroy]
  resources :posts, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :pictures, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
