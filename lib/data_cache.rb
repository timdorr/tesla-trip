class DataCache
  def self.telemetry
    $redis.cache("car-telemetry", 120) do
      TempodbData.new(Time.parse(ENV["START_TIME"])).to_json
    end
  end

  def self.state
    $redis.cache("car-state", 30) do
      tesla_api = TeslaApi.new(ENV['TESLA_EMAIL'], ENV['TESLA_PASS'])
      ms = tesla_api.vehicles.first
      ms.charge_state.merge(ms.drive_state).merge(ms.climate_state).to_json
    end
  end
end