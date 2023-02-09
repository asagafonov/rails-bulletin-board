# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    namespace :admin do
      resources :bulletins, only: :index
      resources :categories, except: :show
    end

    get 'admin/', to: 'admin/bulletins#moderation'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/logout', to: 'auth#logout'

    resources :users, only: :show, path: 'profile'

    resources :bulletins, except: :destroy do
      patch 'update_state', on: :member
    end
  end

  root 'web/bulletins#index'
end
