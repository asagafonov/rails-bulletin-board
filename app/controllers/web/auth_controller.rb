# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      email = auth[:info][:email].downcase
      user = User.find_by(email:)

      if user&.persisted?
        session[:user_id] = user.id
      else
        new_user = User.create!(name: auth[:info][:name], email: auth[:info][:email])
        session[:user_id] = new_user.id
      end

      redirect_to root_path
    end

    private

    def auth
      request.env['omniauth.auth']
    end
  end
end
