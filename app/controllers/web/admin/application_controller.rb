# frozen_string_literal: true

module Web
  class Admin::ApplicationController < ApplicationController
    rescue_from ActiveRecord::DeleteRestrictionError, with: :not_permitted

    private

    def not_permitted
      redirect_to admin_categories_path, alert: t('categories.delete_restriction_error')
    end
  end
end
