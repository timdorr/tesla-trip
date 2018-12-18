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

module TeslaTrip
  class Application < Rails::Application
    config.api_only = true

    config.autoload_paths += %W(#{config.root}/lib)

    require_relative '../app/middleware/telemetry_socket'
    config.middleware.insert_before 0, TeslaTrip::TelemetrySocket
  end
end
