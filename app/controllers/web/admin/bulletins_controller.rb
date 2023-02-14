# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        @query = Bulletin.ransack(params[:query])
        @bulletins = @query.result.by_creation_date_desc.page(params[:page])
      end

      def moderation
        @bulletins_on_moderation = Bulletin.under_moderation.by_creation_date_desc
      end

      def publish
        @bulletin = find_bulletin

        if @bulletin.publish!
          redirect_to admin_root_path, notice: t('bulletins.state.state_changed.publish.success')
        else
          redirect_to admin_root_path, alert: t('bulletins.state.state_changed.failure')
        end
      end

      def reject
        @bulletin = find_bulletin

        if @bulletin.reject!
          redirect_to admin_root_path, notice: t('bulletins.state.state_changed.reject.success')
        else
          redirect_to admin_root_path, alert: t('bulletins.state.state_changed.failure')
        end
      end

      def archive
        @bulletin = find_bulletin

        if @bulletin.archive!
          redirect_to params[:fallback_url], notice: t('bulletins.state.state_changed.archive.success')
        else
          redirect_to params[:fallback_url], alert: t('bulletins.state.state_changed.failure')
        end
      end

      private

      def find_bulletin
        Bulletin.find(params[:id])
      end
    end
  end
end
