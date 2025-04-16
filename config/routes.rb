Rails.application.routes.draw do
  root 'home#index'
  get '/feed', to: 'pages#feed'
  get '/search', to: 'search#index'
  resources :shared_posts, only: [:create, :show, :destroy]
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  devise_for :users
  resources :likes, only: [:create], defaults: {format: :json}
  resources :connections, only: [:index, :create, :destroy] do
    member do
      patch :accept
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
