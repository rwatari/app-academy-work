Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only:[:new, :create]

  post 'cats/:id/approve/:request_id', to: 'cat_rental_requests#approve',
    as: 'approve_rental'

  post 'cats/:id/deny/:request_id', to: 'cat_rental_requests#deny',
    as: 'deny_rental'
end
