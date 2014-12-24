require 'telemetry_socket'
Rails.application.config.middleware.use TeslaTrip::TelemetrySocket
