Rails.application.routes.draw do
  devise_for :admins
  root to: "posts#index"

  resources :posts
end
