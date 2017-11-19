class DataCache
  def self.telemetry
    telematics = InfluxdbData.new.telematics(Time.parse(ENV['START_TIME']), Time.parse(ENV['END_TIME']))
    return if telematics.blank?
    telemetry = telematics.map { |t| {lat: t['est_lat'], lng: t['est_lng']} }
    $redis.set('car-telemetry', telemetry.to_json)

    car_state = JSON.parse($redis.get('car-state')) || {}
    $redis.set('car-state', car_state.merge(InfluxdbData.new.latest_state).to_json)
  end

  def self.state
    # TeslaApi::Client.debug_output
    tesla_api = TeslaApi::Client.new(ENV['TESLA_EMAIL'], ENV['TESLA_CLIENT_ID'], ENV['TESLA_CLIENT_SECRET'])

    token = $redis.cache('tesla-token', 1.hour.to_i) do
      tesla_api.login!(ENV['TESLA_PASS'])
      tesla_api.token
    end
    tesla_api.token = token

    vehicle = $redis.cache('tesla-vehicle', 1.hour.to_i) do
      ms = tesla_api.vehicles.find { |v| v.vin == ENV['TESLA_VIN'] }
      ms.vehicle.to_json
    end
    vehicle = JSON.parse(vehicle)
    ms = TeslaApi::Vehicle.new(tesla_api.class, tesla_api.email, vehicle['id'], vehicle)

    puts 'getting state'
    state = ms.api.get("/vehicles/#{ms.id}/data")['response'] rescue nil
    $redis.set('car-state', state.to_json) if state.present?
  end
end
