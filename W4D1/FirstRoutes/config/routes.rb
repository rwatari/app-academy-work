Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create, :update, :destroy]

  resources :contacts, only: [:index, :show, :create, :update, :destroy]

  resources :contact_shares, only: [:create, :destroy]
  # get 'users/new' => 'users#new', as: 'new_user'
  # get 'users' => 'users#index', as: 'users'
  # post 'users' => 'users#create'
  # get 'users/:id/edit' => 'users#new', as: 'edit_user'
  # get 'users/:id' => 'users#show', as: 'user'
  # patch 'users/:id' => 'users#update'
  # put 'users/:id' => 'users#update'
  # delete 'users/:id' => 'users#destroy'
end
