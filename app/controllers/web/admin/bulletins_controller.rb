# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        @bulletins = Bulletin.includes(:user).by_creation_date_desc
        @page_type = :bulletins
      end

      def moderation
        @bulletins_on_moderation = Bulletin.includes(:user).under_moderation.by_creation_date_desc
        pp @bulletins_on_moderation
        @page_type = :bulletins_on_moderation
      end

      def show
        @bulletin = find_bulletin
      end

      def new
        @bulletin = Bulletin.new
        authorize @bulletin
      end

      def create
        @bulletin = Bulletin.create(bulletin_params)
        authorize @bulletin

        if @bulletin.save
          redirect_to @bulletin, notice: t('bulletins.create.success')
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit
        @bulletin = find_bulletin
        authorize @bulletin
      end

      def update
        @bulletin = find_bulletin
        authorize @bulletin

        if @bulletin.update(bulletin_params)
          redirect_to @bulletin, notice: t('bulletins.update.success')
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @bulletin = find_bulletin
        authorize @bulletin

        if @bulletin.destroy
          redirect_to bulletins_path, notice: t('bulletins.destroy.success')
        else
          redirect_to @bulletin, alert: t('bulletins.destroy.failure')
        end
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

      def bulletin_params
        params.require(:bulletin).permit(:category_id, :description, :image, :title, :user_id)
      end
    end
  end
end
