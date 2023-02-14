# frozen_string_literal: true

module AuthHelper
  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def start_user_session(user)
    session[:user_id] = user.id
  end

  def end_user_session
    session[:user_id] = nil
  end
end
