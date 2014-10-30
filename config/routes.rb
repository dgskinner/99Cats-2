Rails.application.routes.draw do
  
  resources :cats, except: [:index] do
    resources :cat_rental_requests, only: [:index]
  end
  
  resources :cat_rental_requests, except: [:index] do
    post 'approve', :on => :member
    post 'deny', :on => :member
  end
  
  resources :users, only: [:new, :create] do
    resources :cats, only: [:index]
  end
  
  resource :session, only: [:new, :create, :destroy]
  
end
