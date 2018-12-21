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
    state = state.merge(state.delete('vehicle_state'))
    state = state.merge(state.delete('drive_state'))
    state = state.merge(state.delete('charge_state'))
    state = state.merge(state.delete('climate_state'))
    state = state.merge(state.delete('gui_settings'))
    state = state.merge(state.delete('vehicle_config'))

    state.delete('id')
    state.delete('id_s')
    state.delete('vin')
    state.delete('user_id')
    state.delete('vehicle_id')
    state.delete('tokens')

    $redis.set('car-state', state.to_json) if state.present?

    begin
      HTTParty.post("#{ENV['TRIP_URL']}/state", body: { api_token: ENV['WS_TOKEN'], state: state.to_json })
    rescue
      puts "Websocket error: #{$!}"
    end
  end
end
