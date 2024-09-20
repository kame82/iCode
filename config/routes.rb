Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#top'
  resources :users, only: %i[new create]
  # resources :user_sessions, only: [:new, :create, :destroy], as: :login
  resources :codes, only: %i[index new create show edit update destroy] do
    #favoriteを追加
    resource :favorite, only: [:create, :destroy]
    collection do
      get 'favorites'
      get 'my_codes'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get 'terms_of_service', to: 'static_pages#terms_of_service'
end
