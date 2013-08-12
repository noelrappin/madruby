Madruby::Application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :trips
  resources :orders
end
