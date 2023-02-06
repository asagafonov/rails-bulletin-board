# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    namespace :admin do
      resources :bulletins, only: %i[edit update destroy]
    end

    resources :categories, path: 'admin/categories', except: :show

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/logout', to: 'auth#logout'
    get 'profile', to: 'users#index'

    resources :bulletins do
      post 'update_state', on: :member
    end
  end

  root 'web/bulletins#index'
end
