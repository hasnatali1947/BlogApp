Rails.application.routes.draw do
  devise_for :users

  root to: "users#index"

  resources :users do
    resources :posts do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
  
# API routes
  get '/api/users/:user_id/posts', to: 'api/posts#index'
  get '/api/comments/:post_id', to: 'api/comments#index'
  post '/api/users/:user_id/posts/:post_id/comments', to: 'api/comments#create'
  
  # Add the following route for fetching comments for a specific post under API namespace
  get '/api/posts/:post_id/comments', to: 'api/comments#index'
end
