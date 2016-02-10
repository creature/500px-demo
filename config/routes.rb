Rails.application.routes.draw do
  root to: 'photos#popular'
  get 'photos/popular'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: 'sessions#failure'
  delete 'logout', to: 'sessions#destroy'
end
