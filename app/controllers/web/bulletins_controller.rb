# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    def index
      @query = Bulletin.ransack(params[:query])
      @bulletins = @query.result.already_published.by_creation_date_desc.page(params[:page])
    end

    def show
      @bulletin = find_bulletin
    end

    def new
      @bulletin = Bulletin.new
      authorize @bulletin
    end

    def create
      @bulletin = Bulletin.new(bulletin_params)
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

    def to_moderation
      @bulletin = find_bulletin

      if @bulletin.to_moderation!
        redirect_to params[:fallback_url], notice: t('bulletins.state.state_changed.to_moderation.success')
      else
        redirect_to params[:fallback_url], alert: t('bulletins.state.state_changed.failure')
      end
    end

    def publish
      @bulletin = find_bulletin

      if @bulletin.publish!
        redirect_to params[:fallback_url], notice: t('bulletins.state.state_changed.publish.success')
      else
        redirect_to params[:fallback_url], alert: t('bulletins.state.state_changed.failure')
      end
    end

    def reject
      @bulletin = find_bulletin

      if @bulletin.reject!
        redirect_to params[:fallback_url], notice: t('bulletins.state.state_changed.reject.success')
      else
        redirect_to params[:fallback_url], alert: t('bulletins.state.state_changed.failure')
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

    def bulletin_params
      params.require(:bulletin).permit(:category_id, :description, :image, :title, :user_id)
    end
  end
end
