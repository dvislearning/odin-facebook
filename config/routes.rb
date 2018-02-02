Rails.application.routes.draw do
  get 'posts', to: 'posts#index'
  get 'static_pages/new'
  root 'static_pages#new'  
  devise_for :users
  get '/pending', to: 'users#pending'
  resources :users, only: [:show, :index]
  resources :relationships, only: [:create, :update, :destroy]
  resources :posts, only: [:index, :create, :destroy]
  resources :likes, only: [:create, :destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
