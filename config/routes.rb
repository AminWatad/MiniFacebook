Rails.application.routes.draw do
  get 'profile/show'
  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end
  root to: redirect('users/sign_in')
  devise_for :users, 
            controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                           registrations: 'users/registrations'}
  resources :users, only: :show
end
