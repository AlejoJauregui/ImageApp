Rails.application.routes.draw do

  
  devise_for :users
  get 'welcome/index'
  resources :posts
  resources :images
  root 'welcome#index'
  
  #Route to the API
  namespace 'api' do
    namespace 'v1' do
      post 'auth_user' => 'authentication#authenticate_user'
    end
  end


end
