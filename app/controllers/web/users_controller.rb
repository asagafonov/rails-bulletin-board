# frozen_string_literal: true

module Web
  class UsersController < ApplicationController
    def show
      authorize User
      @query = current_user.bulletins.ransack(params[:query])
      @user_bulletins = @query.result.by_creation_date_desc.page(params[:page])
    end
  end
end
