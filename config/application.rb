# frozen_string_literal: true

require_relative 'boot'

require File.expand_path('boot', __dir__)

ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load if %w[development test].include? ENV['RAILS_ENV']

HOSTNAME = ENV.fetch('HOSTNAME', nil)

module RailsProject65
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.available_locales = %i[ru en]
    config.i18n.default_locale = :ru

    config.active_storage.service = :yandex
  end
end
