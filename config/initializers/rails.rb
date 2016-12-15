# These are all the default Rails initializers in one file.

# Do not halt callback chains when a callback returns false. This is a new
# Rails 5.0 default, so it is introduced as a configuration option to ensure
# that apps made with earlier versions of Rails are not affected when upgrading.
ActiveSupport.halt_callback_chains_on_return_false = false

# Specify a serializer for the signed and encrypted cookie jars.
# Valid options are :json, :marshal, and :hybrid.
Rails.application.config.action_dispatch.cookies_serializer = :json

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password]

# Enable per-form CSRF tokens.
Rails.application.config.action_controller.per_form_csrf_tokens = true

# Enable origin-checking CSRF mitigation.
Rails.application.config.action_controller.forgery_protection_origin_check = true

Rails.application.config.session_store :cookie_store, key: '_tesla-trip_session'

# Configure SSL options to enable HSTS with subdomains.
Rails.application.config.ssl_options = { hsts: { subdomains: true } }

# Preserve the timezone of the receiver when calling to `to_time`.
# Ruby 2.4 will change the behavior of `to_time` to preserve the timezone
# when converting to an instance of `Time` instead of the previous behavior
# of converting to the local system timezone.
#
# Rails 5.0 introduced this config option so that apps made with earlier
# versions of Rails are not affected when upgrading.
ActiveSupport.to_time_preserves_timezone = true

# This file contains settings for ActionController::ParamsWrapper which
# is enabled by default.

# Enable parameter wrapping for JSON. You can disable this by setting :format to an empty array.
ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: [:json]
end

# To enable root element in JSON for ActiveRecord objects.
# ActiveSupport.on_load(:active_record) do
#   self.include_root_in_json = true
# end
