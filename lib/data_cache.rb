class DataCache
  def self.telemetry
    telematics = InfluxdbData.new.telematics(Time.parse(ENV["START_TIME"]), Time.parse(ENV["END_TIME"]))
    return if telematics.blank?
    telemetry = telematics.map { |t| {lat: t["est_lat"], lng: t["est_lng"]} }
    $redis.set("car-telemetry", telemetry.to_json)

    car_state = JSON.parse($redis.get("car-state")) || {}
    $redis.set("car-state", car_state.merge(InfluxdbData.new.latest_state).to_json)
  end

  def self.state
    tesla_api = TeslaApi::Client.new(ENV["TESLA_EMAIL"], ENV["TESLA_PASS"], ENV["TESLA_CLIENT_ID"], ENV["TESLA_CLIENT_SECRET"])
    ms = tesla_api.vehicles.first
    return if ms.state != "online"

    puts "getting charge state"
    charge_state = ms.charge_state rescue nil
    if charge_state.present?
      car_state = JSON.parse($redis.get("car-state")) || {}
      $redis.set("car-state", car_state.merge(charge_state).to_json)
    end

    puts "getting drive state"
    drive_state = ms.drive_state rescue nil
    if drive_state.present?
      car_state = JSON.parse($redis.get("car-state")) || {}
      $redis.set("car-state", car_state.merge(drive_state).to_json)
    end

    puts "getting climate state"
    climate_state = ms.climate_state rescue nil
    if climate_state.present?
      car_state = JSON.parse($redis.get("car-state")) || {}
      $redis.set("car-state", car_state.merge(climate_state).to_json)
    end
  end
end
