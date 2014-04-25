BandBlitz::Application.routes.draw do
  # Generated routes
  resources :bands
  resources :genres

  # Default route
  root :to => 'bands#index', :as => :home

  resources :users
  resources :sessions
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
end
