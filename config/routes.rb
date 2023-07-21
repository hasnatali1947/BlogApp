Rails.application.routes.draw do
    
    root 'users#index'
    get '/users'                   => 'users#index'
    get '/users/:id'               => 'users#show'
    get '/users/:user_id/posts'     => 'posts#index'
    get '/users/:user_id/posts/:id' => 'posts#show'
    get '/posts/new'                => 'posts#new'
    get '/users/:id/posts/:id/comments/new', to: 'comments#new'

    resources :users do
        resources :posts do 
            resources :comments
            resources :likes
        end
    end
end

