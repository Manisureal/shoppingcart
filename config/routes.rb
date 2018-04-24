Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # All Routes for devise users
  devise_for :users
  # To help signout admin users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'pages#home'
  resources :products, only: [:index, :show]
  resources :order_items
  resource :cart, only: [:show, :destroy, :create]
  resources :orders#, only: [:index, :show, :destroy, :new]

end
