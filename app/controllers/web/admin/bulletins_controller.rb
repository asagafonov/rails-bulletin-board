# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        authorize Bulletin, :moderation?
        @query = Bulletin.ransack(params[:query])
        @bulletins = @query.result.by_creation_date_desc.page(params[:page])
        @page_type = :bulletins
      end

      def moderation
        authorize Bulletin
        @bulletins_on_moderation = Bulletin.under_moderation.by_creation_date_desc
        @page_type = :bulletins_on_moderation
      end

      def publish
        @bulletin = find_bulletin
        authorize @bulletin

        url = params[:fallback_url] || admin_bulletins_path

        if @bulletin.publish!
          redirect_to url, notice: t('bulletins.state.state_changed.publish.success')
        else
          redirect_to url, alert: t('bulletins.state.state_changed.failure')
        end
      end

      def reject
        @bulletin = find_bulletin
        authorize @bulletin

        url = params[:fallback_url] || admin_bulletins_path

        if @bulletin.reject!
          redirect_to url, notice: t('bulletins.state.state_changed.reject.success')
        else
          redirect_to url, alert: t('bulletins.state.state_changed.failure')
        end
      end

      def archive
        @bulletin = find_bulletin
        authorize @bulletin

        url = params[:fallback_url] || admin_bulletins_path

        if @bulletin.archive!
          redirect_to url, notice: t('bulletins.state.state_changed.archive.success')
        else
          redirect_to url, alert: t('bulletins.state.state_changed.failure')
        end
      end

      private

      def find_bulletin
        Bulletin.find(params[:id])
      end
    end
  end
end
