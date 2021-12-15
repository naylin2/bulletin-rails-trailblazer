Rails.application.routes.draw do
  root "posts#index"
  # get '/posts', to:"posts#index"
  # get '/posts/new', to:"posts#new", as: 'new_post'
  # post '/posts', to:"posts#create", as: 'create_post'
  # get '/posts/:id', to:"posts#show", as: 'post'
  # patch '/posts/:id', to:"posts#update", as: 'update_post'
  # delete '/posts/:id', to:"posts#destroy"
  # get '/posts/:id/edit', to:"posts#edit", as: 'edit_post'

  resources :posts do
    collection do
      get :confirm_create, to: "posts#new"
      post :confirm_create
    end
    member do
      get :confirm_update, to: "posts#confirm_update"
      post :confirm_update
      post :update_post
    end
  end


end