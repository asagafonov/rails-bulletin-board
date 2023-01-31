# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  helper_method :current_user

  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
