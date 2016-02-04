Rails.application.routes.draw do
  devise_for :admins, path: 'admin'
  devise_for :users
  resources :books, only: [:index, :show]
  resources :line_items, only: [:create, :update, :destroy]
  resources :order_items, only: [:create, :update, :destroy]
  resources :carts, only: :show
  resources :charges, only: [:new, :create]
  namespace :admin do
    resources :books
    resources :dashboard, only: :index
  end
  root 'books#index'
end
