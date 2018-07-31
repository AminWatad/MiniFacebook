Rails.application.routes.draw do
  get 'images/new'
  post 'images/create'
  get 'images/show'
  get 'explore/index'
  post 'likes', to: 'likes#create'
  post 'profile/request', to: 'profile#request_friendship'
  post 'profile/unrequest', to: 'profile#delete_request'
  post 'profile/accept', to: 'profile#accept'
  post 'profile/decline', to: 'profile#decline'
  get 'likes_show', to: 'likes#show'
  delete 'likes/destroy'
  authenticated :user do
    root to: 'home#index', as: :authenticated_root
    get 'comment/new', to: 'comments#new'
    post 'comment/create', to: 'comments#create'
    resources :post, only: [:show]
  end
  root to: redirect('users/sign_in')
  devise_for :users, 
            controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                           registrations: 'users/registrations'}
  resources :posts, only: [:create]
  resources :profile, only: [:show]
end
