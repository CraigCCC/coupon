Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'stores#index'
  resources :stores, only: [:index, :show]

  namespace :admin do
    root 'stores#index'
    resources :stores
  end
end
