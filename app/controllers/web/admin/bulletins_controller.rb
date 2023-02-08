# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        @query = Bulletin.ransack(params[:query])
        @bulletins = @query.result.by_creation_date_desc
        @page_type = :bulletins
      end

      def moderation
        @bulletins_on_moderation = Bulletin.under_moderation.by_creation_date_desc
        @page_type = :bulletins_on_moderation
      end

      def show
        @bulletin = find_bulletin
      end

      def update_state
        @bulletin = find_bulletin

        BulletinStateOperation.new.call(bulletin: @bulletin, key: params[:state_operation_key])
        redirect_to user_path(current_user)
      end

      private

      def find_bulletin
        Bulletin.find(params[:id])
      end
    end
  end
end
