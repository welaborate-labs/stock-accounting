require 'sidekiq/web'

Rails.application.routes.draw do
  get 'landing/index'
  root to: 'landing#index'

  get   '/auth/:provider/callback',           to: 'sessions#create'
  get   '/login',                             to: 'sessions#new'
  get   '/auth/failure',                      to: 'sessions#failure'
  get   '/logout',                            to: 'sessions#destroy', via: [:get, :post]
  get   '/signup',                            to: 'identities#new' # registering user with omniauth-identity

  resources :identities
  resources :statements
  resources :users,                           only: [:show]
  resources :accounts,                        only: [:new, :edit, :create, :update]
  resources :statement_files,                 only: [:index, :new, :create, :destroy]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  mount Sidekiq::Web, at: '/sidekiq' if Rails.env.development?
end
