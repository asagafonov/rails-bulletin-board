# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < ApplicationController
      def index
        authorize Category
        @categories = Category.all
      end

      def new
        @category = Category.new
        authorize @category
      end

      def create
        @category = Category.new(category_params)
        authorize @category

        if @category.save
          redirect_to categories_path, notice: t('admin.categories.success')
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit
        @category = Category.find(params[:id])
        authorize @category
      end

      def update
        @category = Category.find(params[:id])
        authorize @category

        if @category.update(category_params)
          redirect_to categories_path, notice: t('admin.categories.update.success')
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @category = Category.find(params[:id])
        authorize @category

        if @category.destroy
          redirect_to categories_path, notice: t('admin.categories.destroy.success')
        else
          redirect_to @category, alert: t('admin.categories.destroy.failure')
        end
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end