# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_for :views
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
  resources :users do
    resources :posts do
      member do
        post 'like'
        delete 'unlike'
      end
      resources :comments
    end
  end
end
