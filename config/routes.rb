# frozen_string_literal: true

Rails.application.routes.draw do
  root 'sessions#welcome'

  # for posts
  resources :posts do
    collection do
      get :confirm_create, to: 'posts#new'
      post :confirm_create
      get :upload_csv
      post :import_csv
      get :download
    end
    member do
      get :confirm_update, to: 'posts#confirm_update'
      post :confirm_update
      post :update_post
    end
  end

  # for users
  resources :users do
    collection do
      post :confirm_create
      get :confirm_create, to: 'users#new'
      get :search_user
    end
    member do
    end
  end

  # for login
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/login'
  get 'sessions/welcome'

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#log_out'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'

  # for password reset
  get 'password/:id', to: 'passwords#edit', as: 'edit_password'
  post 'password/:id', to: 'passwords#update'

  get 'reset/password', to: 'passwords#new'
  post 'reset/password', to: 'passwords#create'
  get 'password/reset/edit', to: 'passwords#editReset'
  patch 'password/reset/edit', to: 'passwords#updateReset'

end
