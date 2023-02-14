# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < ApplicationController
      def index
        @categories = Category.all
      end

      def new
        @category = Category.new
      end

      def create
        @category = Category.new(category_params)

        if @category.save
          redirect_to admin_categories_path, notice: t('admin.categories.create.success')
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit
        @category = Category.find(params[:id])
      end

      def update
        @category = Category.find(params[:id])

        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t('admin.categories.update.success')
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @category = Category.find(params[:id])

        if @category.destroy
          redirect_to admin_categories_path, notice: t('admin.categories.destroy.success')
        else
          redirect_to admin_categories_path, alert: t('admin.categories.destroy.failure')
        end
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
