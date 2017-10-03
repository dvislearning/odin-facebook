Rails.application.routes.draw do
  get 'static_pages/new'
  root 'static_pages#new'  


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
