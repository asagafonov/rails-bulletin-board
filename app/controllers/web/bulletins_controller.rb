# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.by_creation_order_desc
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def new
      @bulletin = Bulletin.new
    end

    def create
      return unless current_user

      @bulletin = Bulletin.create(bulletin_params)

      if @bulletin.save
        redirect_to bulletin_path(@bulletin)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @bulletin = Bulletin.find(params[:id])
    end

    def update
      return unless current_user

      @bulletin = Bulletin.find(params[:id])

      if @bulletin.update(bulletin_params)
        redirect_to bulletin_path(@bulletin)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      return unless current_user

      @bulletin = Bulletin.find(params[:id])

      if @bulletin.destroy
        redirect_to bulletins_path
      else
        @bulletin.reload
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image)
    end
  end
end
