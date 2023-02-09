# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    namespace :admin do
      resources :bulletins, only: :index do
        patch 'publish', on: :member
        patch 'reject', on: :member
        patch 'archive', on: :member
      end
      resources :categories, except: :show
    end

    get '/admin', to: 'admin/bulletins#moderation'
    get '/profile', to: 'users#show'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/logout', to: 'auth#logout'

    resources :bulletins, except: :destroy do
      patch 'to_moderation', on: :member
      patch 'archive', on: :member
    end
  end

  root 'web/bulletins#index'
end
