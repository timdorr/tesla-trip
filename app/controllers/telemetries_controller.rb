class TelemetriesController < ApplicationController
  respond_to :json
  before_action :ensure_authentication_token, only: [:create]
  protect_from_forgery with: :null_session

  def show
    data = $redis.get('car-telemetry')
    respond_with data
  end

  def state
    state = $redis.get('car-state')
    respond_with state
  end

  def create
    stream = JSON.parse(stream_params[:state])
    $redis.publish(TeslaTrip::TelemetrySocket::CHANNEL, map_stream_to_state(stream).to_json)
    render json: {status: 'ok'}
  end

  private

  def ensure_authentication_token
    if stream_params[:api_token] != ENV['WS_TOKEN']
      render json: {error: 'Bad api token'}, status: :unauthorized
      false
    end
  end

  def stream_params
    params.permit(:api_token, :state)
  end

  def map_stream_to_state(stream)
    {
        'heading' => stream['est_heading'],
        'latitude' => stream['est_lat'],
        'longitude' => stream['est_lng'],
        'speed' => stream['speed'],
        'battery_level' => stream['soc']
    }
  end
end
