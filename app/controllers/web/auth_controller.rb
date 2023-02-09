# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize

module Web
  class AuthController < ApplicationController
    def callback
      name = auth[:name] || nil
      email = auth[:email]
      user = User.find_by(email:)

      if user&.persisted?
        session[:user_id] = user.id
      else
        new_user = User.create!(name:, email:)
        session[:user_id] = new_user.id
      end

      redirect_to root_path, notice: t('views.auth.actions.login.success')
    end

    def logout
      session[:user_id] = nil
      redirect_to root_path, notice: t('views.auth.actions.logout.success')
    end

    private

    def auth
      data = request.env['omniauth.auth']
      { email: data[:info][:email], name: data[:info][:name] }
    end
  end
end

# rubocop:enable Metrics/AbcSize
