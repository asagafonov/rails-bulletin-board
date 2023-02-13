# frozen_string_literal: true

module Web
  class UsersController < ApplicationController
    def show
      authorize User
      @query = Bulletin.ransack(params[:query])
      @user_bulletins = @query.result.where(user_id: current_user&.id).by_creation_date_desc.page(params[:page])
    end
  end
end
