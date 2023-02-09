# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      name = auth[:name] || nil
      email = auth[:email]

      redirect_to root_path, alert: t('views.auth.actions.login.failure') and return unless email

      add_user_to_session(name, email)

      redirect_to root_path, notice: t('views.auth.actions.login.success')
    end

    def logout
      session[:user_id] = nil
      redirect_to root_path, notice: t('views.auth.actions.logout.success')
    end

    private

    def add_user_to_session(name, email)
      user = User.find_by(email:)

      if user&.persisted?
        session[:user_id] = user.id
      else
        new_user = User.create!(name:, email:)
        session[:user_id] = new_user.id
      end
    end

    def auth
      data = request.env['omniauth.auth']
      { email: data[:info][:email], name: data[:info][:name] }
    end
  end
end
