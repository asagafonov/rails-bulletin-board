# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    include AuthConcern

    def callback
      name = auth[:name] || nil
      email = auth[:email]

      redirect_to root_path, alert: t('views.auth.actions.login.failure') and return unless email

      start_session(name, email)
    end

    def end_session
      sign_out
      redirect_to root_path, notice: t('views.auth.actions.logout.success')
    end

    private

    def start_session(name, email)
      user = User.find_or_initialize_by(email:)
      user.name = name

      if user.save
        sign_in(user)
        redirect_to root_path, notice: t('views.auth.actions.login.success')
      else
        redirect_to root_path, alert: t('views.auth.actions.save_user.failure')
      end
    end

    def auth
      data = request.env['omniauth.auth']
      { email: data[:info][:email], name: data[:info][:name] }
    end
  end
end
