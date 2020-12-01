class StatesController < ApplicationController
  before_action :ensure_authentication_token, only: [:create]

  def show
    state = $redis.get('car-state')
    respond_with state
  end

  def create
    stream = JSON.parse(stream_params[:state])
    $redis.publish(TelemetrySocket::CHANNEL, format_state(stream).to_json)
    render json: {status: 'ok'}
  end

  private

  def format_state(state)
    {
        type: 'state'
    }.merge(state)
  end
end
