Madruby::Application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :trip
end
