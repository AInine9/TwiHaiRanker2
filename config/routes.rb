Rails.application.routes.draw do
  resources :home, only: :index
  root 'home#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
