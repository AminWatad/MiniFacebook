Rails.application.routes.draw do
  post 'likes', to: 'likes#create'
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
