Rails.application.routes.draw do
  root 'home#index'
  get '/feed', to: 'pages#feed'
  get '/search', to: 'search#index'
  post '/shared-posts', to: 'shared_posts#create'
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  devise_for :users
  resources :likes, only: [:create, :destroy]
  resources :connections, only: [:create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
