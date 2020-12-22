require 'sidekiq/web'

Rails.application.routes.draw do
  get 'landing/index'
  root to: 'landing#index'

  match '/auth/:provider/callback',           to: 'sessions#create', via: [:get, :post]
  get   '/login',                             to: 'sessions#new'
  get   '/auth/failure',                      to: 'sessions#failure'
  match '/logout',                            to: 'sessions#destroy', via: [:get, :post]
  get   '/signup',                            to: 'identities#new' # registering user with omniauth-identity
  get   '/home',                              to: 'homes#index'
  post '/contact/submit',                     to: 'forms#submit_contact'
  put   '/account/choose',                    to: 'accounts#choose'

  resources :accounts
  resources :identities
  resources :statements
  resources :users,                           only: [:show]
  resources :statement_files,                 only: [:index, :new, :create, :destroy]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  mount Sidekiq::Web, at: '/sidekiq' if Rails.env.development?
end
 