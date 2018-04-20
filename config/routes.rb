Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  root to: 'pages#home'
  resources :products, only: [:index, :show]
  resources :order_items
  resource :cart, only: [:show, :destroy, :create]
  resources :orders#, only: [:index, :show, :destroy, :new]

end
