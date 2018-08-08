Rails.application.routes.draw do

  
  get 'welcome/index'
  resources :posts
  resources :images
  root 'welcome#index'

end
