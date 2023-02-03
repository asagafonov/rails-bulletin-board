# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.includes(:user).by_creation_date_desc
    end

    def show
      @bulletin = Bulletin.find(params[:id])
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
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def update
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: t('bulletins.update.success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin

      if @bulletin.destroy
        redirect_to bulletins_path, notice: t('bulletins.destroy.success')
      else
        redirect_to @bulletin, alert: t('bulletins.destroy.failure')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:category_id, :description, :image, :title, :user_id)
    end
  end
end
