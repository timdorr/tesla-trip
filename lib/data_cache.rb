class DataCache
  def self.telemetry
    telemetry = TempodbData.new(Time.parse(ENV["START_TIME"])).to_json
    $redis.set("car-telemetry", telemetry)
  end

  def self.state
    tesla_api = TeslaApi.new(ENV['TESLA_EMAIL'], ENV['TESLA_PASS'])
    ms = tesla_api.vehicles.first
    state = ms.charge_state.merge(ms.drive_state).merge(ms.climate_state).to_json
    $redis.set("car-state", state)
  end
end