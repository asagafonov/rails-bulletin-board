# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    namespace :admin do
      resources :bulletins, only: :index do
        patch 'publish', on: :member
        patch 'reject', on: :member
        patch 'archive', on: :member
      end
      resources :categories, only: %i[index new create edit update destroy]
      root 'bulletins#moderation'
    end

    resource :user, only: :show, path: '/profile', as: :profile

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/logout', to: 'auth#logout'

    resources :bulletins, only: %i[index show new create edit update] do
      patch 'to_moderation', on: :member
      patch 'archive', on: :member
    end
  end

  root 'web/bulletins#index'
end
