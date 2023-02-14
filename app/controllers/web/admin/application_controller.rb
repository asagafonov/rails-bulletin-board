# frozen_string_literal: true

module Web
  class Admin::ApplicationController < ApplicationController
    before_action :check_admin_rights
    rescue_from ActiveRecord::DeleteRestrictionError, with: :not_permitted

    private

    def not_permitted
      redirect_to admin_categories_path, alert: t('categories.delete_restriction_error')
    end

    def check_admin_rights
      redirect_to root_path, alert: t('not_admin_error') unless current_user&.admin?
    end
  end
end
