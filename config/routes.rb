Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'stores#index'
  resources :stores, only: [:index, :show] do
    resources :products, only: [:show]
  end

  resource :cart, only: [:show, :destroy] do
    collection do
      post :add, path: 'add/:id'
    end
  end

  namespace :admin do
    root 'stores#index'
    resources :stores do
      resources :products
    end
  end
end
