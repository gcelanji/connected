Rails.application.routes.draw do
  root 'home#index'
  get '/feed', to: 'pages#feed'
  resources :posts
  devise_for :users
  resources :likes, only: [:create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
