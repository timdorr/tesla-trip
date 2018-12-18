class TelemetriesController < ApplicationController
  before_action :ensure_authentication_token, only: [:create]

  def show
    data = $redis.get('car-telemetry')
    respond_with data
  end

  def create
    stream = JSON.parse(stream_params[:state])
    $redis.publish(TeslaTrip::TelemetrySocket::CHANNEL, format_state(stream).to_json)
    render json: {status: 'ok'}
  end

  private

  def format_state(stream)
    {
        type: 'telemetry',
        heading: stream['est_heading'],
        latitude: stream['est_lat'],
        longitude: stream['est_lng'],
        speed: stream['speed'],
        battery_level: stream['soc']
    }
  end
end
