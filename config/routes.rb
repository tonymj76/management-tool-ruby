Rails.application.routes.draw do
  resources :projects do
    resources :tasks
  end
  resources :users
  get '/register', to: 'users#new', as: 'new_user_registration'
  get    '/login',   to: 'sessions#new', as: 'new_user_session'
  post   '/login',   to: 'sessions#login', as: 'user_session'
  delete '/logout',  to: 'sessions#destroy', as: 'destroy_user_session'
  root to: "users#index"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
