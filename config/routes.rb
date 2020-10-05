Rails.application.routes.draw do
  root to: 'sessions#new' # new_sessions_path

  get   '/auth/:provider/callback',           to: 'sessions#create'
  get   '/login',                             to: 'sessions#new'
  get   '/auth/failure',                      to: 'sessions#failure'
  get   '/logout',                            to: 'sessions#destroy', via: [:get, :post]
  get   '/signup',                            to: 'identities#new' # registering user with omniauth-identity
  get   '/profile' ,                          to: 'users#profile'

  resources :identities
  resources :password_resets

  # Gives letter_opener an interface for browsing sent emails: http:localhost:3000/letter_opener
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
