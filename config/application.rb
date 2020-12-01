require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
# require 'active_model/railtie'
# require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
# require 'sprockets/railtie'
# require 'action_mailer/railtie'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require_relative '../app/middleware/telemetry_socket'

module TeslaTrip
  class Application < Rails::Application
    config.load_defaults "6.0"

    config.api_only = true

    config.autoload_paths << "#{config.root}/lib"
    config.autoload_paths << "#{config.root}/app/middleware"

    config.middleware.insert_before 0, ::TelemetrySocket
  end
end
