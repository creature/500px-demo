Rails.application.routes.draw do
  root to: 'photos#popular'
  get 'photos/popular'
  get 'photos/:id/like', to: 'photos#like', as: 'like_photo'
  get 'photos/:id/unlike', to: 'photos#unlike', as: 'unlike_photo'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: 'sessions#failure'
  get 'logout', to: 'sessions#logout'
  delete 'logout', to: 'sessions#destroy'
end
