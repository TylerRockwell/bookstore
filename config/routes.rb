Rails.application.routes.draw do
  devise_for :admins, path: 'admin'
  devise_for :users
  resources :books, only: [:index, :show]
  resources :line_items, only: [:create, :update, :destroy]
  resources :orders, only: [:new, :create, :show]
  resources :order_items, only: [:create, :update, :destroy]
  resources :carts, only: :show
  resources :charges, only: [:new, :create]
  namespace :admin do
    get 'dashboard' => 'dashboard#index'
    resources :books
    resources :orders, only: :index
  end
  root 'books#index'
end
