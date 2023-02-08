# frozen_string_literal: true

module Web
  class UsersController < ApplicationController
    def show
      @query = Bulletin.ransack(params[:query])
      @user_bulletins = @query.result.where(user_id: params[:id]).by_creation_date_desc
    end
  end
end
