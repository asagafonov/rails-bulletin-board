# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api

  scope module: :web do
    namespace :admin

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resource :bulletins

    root 'bulletins#index'
  end
end
