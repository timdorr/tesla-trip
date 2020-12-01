class TeslaStreamReader
  def stream_to_influxdb
    loop do
      loop do
        puts 'Waiting for car to come online...'
        break if car.state == 'online'
        @car = nil
        sleep 5
      end

      puts 'Car online! Streaming car telematics...'
      car.stream do |state|
        puts "Received state: #{state.inspect}"
        write_to_influxdb(state)
        write_to_socket(state)
      end
      puts 'Stream closed!'

      @tesla_api = nil
      @car = nil
    end
  end

  private

  def tesla_api
    @tesla_api ||= TeslaClient.build
  end

  def car
    @car ||= tesla_api.vehicles.find { |v| v.vin == ENV['TESLA_VIN'] }
  end

  def write_to_influxdb(state)
    state[:time] = state[:time].to_i
    $influxdb.write_point('telematics', { values: state })
  end

  def write_to_socket(state)
    Faraday.post("#{ENV['TRIP_URL']}/telemetry", api_token: ENV['WS_TOKEN'], state: state.to_json)
  rescue
    puts "Websocket error: #{$!}"
  end
end
