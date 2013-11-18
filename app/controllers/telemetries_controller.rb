class TelemetriesController < ApplicationController
  respond_to :json

  def show
    data = TempodbData.new(Time.parse(ENV["START_TIME"]))
    Rails.logger.info(data)
    respond_with data
  end

  def state
    state = $redis.cache("car-state", 30) do
      tesla_api = TeslaApi.new(ENV['TESLA_EMAIL'], ENV['TESLA_PASS'])
      ms = tesla_api.vehicles.first
      ms.charge_state.merge(ms.drive_state).merge(ms.climate_state).to_json
    end

    respond_with JSON.parse(state)
  end
end