Rails.application.routes.draw do
  root to: 'sessions#new'

  get   '/auth/:provider/callback',           to: 'sessions#create'
  get   '/login',                             to: 'sessions#new'
  get   '/auth/failure',                      to: 'sessions#failure'
  get   '/logout',                            to: 'sessions#destroy', via: [:get, :post]
  get   '/signup',                            to: 'identities#new' # registering user with omniauth-identity

  resources :identities
  resources :statement_files,                 only: [:index, :new, :create, :destroy]

  # Gives letter_opener an interface for browsing sent emails: 
  # http:localhost:3000/letter_opener
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
