Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root to: "posts#index"

  resources :posts
  resources :index, :path => "home"
  
  resources :posts do 
    member do
      put "upvote", to: "posts#upvote"
      put "downvote", to: "posts#downvote"
    end
  end
  
  mount Commontator::Engine => '/commontator'
end
