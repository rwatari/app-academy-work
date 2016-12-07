Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only:[:new, :create] do
    post "approve", on: :member
    post "deny", on: :member
  end

  root to: "cats#index"
end
