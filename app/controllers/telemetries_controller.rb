class TelemetriesController < ApplicationController
  respond_to :json

  def show
    data = $redis.cache("car-telemetry", 120) do
      TempodbData.new(Time.parse(ENV["START_TIME"]))
    end
    respond_with data
  end

  def state
    state = $redis.cache("car-state", 30) do
      tesla_api = TeslaApi.new(ENV['TESLA_EMAIL'], ENV['TESLA_PASS'])
      ms = tesla_api.vehicles.first
      ms.charge_state.merge(ms.drive_state).merge(ms.climate_state)
    end

    respond_with state
  end
end