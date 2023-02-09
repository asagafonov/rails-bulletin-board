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

    def update_state
      @bulletin = find_bulletin

      if BulletinStateOperation.new.call(bulletin: @bulletin, key: params[:state_operation_key])
        redirect_to params[:fallback_url], notice: t('bulletins.state.state_changed.success')
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
