require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "sprockets/railtie"
# require "action_mailer/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module TeslaTrip
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
  end
end
