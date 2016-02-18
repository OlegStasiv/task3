Rails.application.routes.draw do
  get 'friendships/create' => 'friendships#create'
  post 'friendships/update' => 'friendships#update'
  delete 'friendships/destroy' => 'friendships#destroy'

  resources :users

  resources :sessions, only: [:new, :create, :destroy]

  root 'static_pages#home'

  get 'contact' => 'static_pages#contact', as: :contact
  get 'about' => 'static_pages#about', as: :about
  get 'help' => 'static_pages#help', as: :help


  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'
  get 'signout' => 'sessions#destroy', as: :destroy
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  namespace :api do
    namespace :v1 do
      resources :users
      post 'users/profile' => 'users#profile'
      post 'users/login'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :friendships do
        collection do
          get  :my_friends
          get  :who_want
        end
      end

    end
  end

  namespace :api do
    namespace :v1 do
      resources :friendships
          post 'friendships/create' => 'friendships#create'
          post 'friendships/update' => 'friendships#update'
          post 'friendships/destroy' => 'friendships#destroy'
    end
  end

  resources :conversations do
    resources :messages
  end


end
