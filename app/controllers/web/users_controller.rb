# frozen_string_literal: true

module Web
  class UsersController < ApplicationController
    def show
      @user = User.find_by(params[:id])
      @user_bulletins = @user.bulletins.by_creation_date_desc
    end
  end
end
