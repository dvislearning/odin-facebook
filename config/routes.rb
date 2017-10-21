Rails.application.routes.draw do
  get 'static_pages/new'
  root 'static_pages#new'  
  devise_for :users
  resources :users, only: [:show, :index]
  resources :relationships, only: [:create, :destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
