require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LsatCracked
  class Application < Rails::Application
    config.load_defaults 6.0

    config.active_job.queue_adapter = :sidekiq

    config.generators do |generate|
      generate.helper false
      generate.javascripts false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      generate.test_framework :rspec
      generate.view_specs false
    end

    config.to_prepare do
      ActionText::ContentHelper.allowed_tags << "iframe"
    end
  end
end
