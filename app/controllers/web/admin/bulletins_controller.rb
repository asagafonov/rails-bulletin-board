# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        authorize Bulletin
        @query = Bulletin.ransack(params[:query])
        @bulletins = @query.result.by_creation_date_desc.page(params[:page])
        @page_type = :bulletins
      end

      def moderation
        authorize Bulletin
        @bulletins_on_moderation = Bulletin.under_moderation.by_creation_date_desc
        @page_type = :bulletins_on_moderation
      end
    end
  end
end
