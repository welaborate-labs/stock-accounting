Rails.application.routes.draw do
  root to: 'sessions#new' # new_sessions_path

  match '/auth/:provider/callback',           to: 'sessions#create',  via: [:get, :post] #registering user with other providers (google and facebook)
  get   '/login',                             to: 'sessions#new'
  get   '/auth/failure',                      to: 'sessions#failure'
  get   '/logout',                            to: 'sessions#destroy', via: [:get, :post]
  get   '/signup',                            to: 'identities#new' # registering user with omniauth-identity

  resources :identities
  resources :password_resets

  # Gives letter_opener an interface for browsing sent emails: http:localhost:3000/letter_opener
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
