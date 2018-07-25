Rails.application.routes.draw do
  post 'likes', to: 'likes#create'
  get 'likes/destroy'
  get 'profile/show', to: 'profile#show'
  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end
  root to: redirect('users/sign_in')
  devise_for :users, 
            controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                           registrations: 'users/registrations'}
  resources :posts, only: [:create]
end
