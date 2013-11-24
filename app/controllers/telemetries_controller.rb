class TelemetriesController < ApplicationController
  respond_to :json

  def show
    data = $redis.get("car-telemetry")
    respond_with data
  end

  def state
    state = $redis.get("car-state")
    respond_with state
  end
end