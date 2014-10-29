Rails.application.routes.draw do
  
  resources :cats do
    resources :cat_rental_requests, only: [:index]
  end
  
  resources :cat_rental_requests, except: [:index] do
    post 'approve', :on => :member
    post 'deny', :on => :member
  end
  
  resources :users, only: [:new, :create]
  
  resource :session, only: [:new, :create, :destroy]
  
end
