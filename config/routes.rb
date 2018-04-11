Rails.application.routes.draw do
  get 'carts/show'

  get 'carts_controller/show'

  get 'order_items/create'

  get 'products/index'

  root to: 'pages#home'
  resources :products
  resources :order_items
end
