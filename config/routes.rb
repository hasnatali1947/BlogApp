Rails.application.routes.draw do
    
    root 'users#index'
    get '/users'                   => 'users#index'
    get '/users/:id'               => 'users#show'
    get '/users/:user_id/posts'     => 'posts#index'
    get '/users/:user_id/posts/:id' => 'posts#show'
end
