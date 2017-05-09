Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root to: "posts#index"

  resources :posts
  resources :index, :path => "home"
  
end
