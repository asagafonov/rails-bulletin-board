# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    def index
      @query = Bulletin.ransack(params[:query])
      @bulletins = @query.result.published.by_creation_date_desc.page(params[:page])
    end

    def show
      @bulletin = find_bulletin
      authorize @bulletin
    end

    def new
      authorize Bulletin
      @bulletin = Bulletin.new
    end

    def create
      authorize Bulletin
      @bulletin = current_user.bulletins.new(bulletin_params)

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

    def to_moderation
      @bulletin = find_bulletin
      authorize @bulletin

      if @bulletin.to_moderation!
        redirect_to profile_path, notice: t('bulletins.state.state_changed.to_moderation.success')
      else
        redirect_to profile_path, alert: t('bulletins.state.state_changed.failure')
      end
    end

    def archive
      @bulletin = find_bulletin
      authorize @bulletin

      if @bulletin.archive!
        redirect_to profile_path, notice: t('bulletins.state.state_changed.archive.success')
      else
        redirect_to profile_path, alert: t('bulletins.state.state_changed.failure')
      end
    end

    private

    def find_bulletin
      Bulletin.find(params[:id])
    end

    def bulletin_params
      params.require(:bulletin).permit(:category_id, :description, :image, :title)
    end
  end
end
