Rails.application.routes.draw do
  # get 'carts/show'

  get 'order_items/create'

  get 'products/index'

  root to: 'pages#home'
  resources :products
  resources :order_items
  resource :cart, only: [:show, :destroy]
  resources :orders, only: [:index, :show]
end
