class DataCache
  def self.telemetry
    telematics = InfluxdbData.new.telematics(Time.parse(ENV["START_TIME"]))
    telemetry = telematics.map { |t| {lat: t["est_lat"], lng: t["est_lng"]} }
    $redis.set("car-telemetry", telemetry.to_json)
  end

  def self.state
    tesla_api = TeslaApi.new(ENV['TESLA_EMAIL'], ENV['TESLA_PASS'])
    ms = tesla_api.vehicles.first
    state = ms.charge_state.merge(ms.drive_state).merge(ms.climate_state).to_json
    $redis.set("car-state", state)
  end
end
