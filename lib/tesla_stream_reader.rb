class TeslaStreamReader
  def initialize
    $stdout.sync = true
  end

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
    @tesla_api ||= begin
      tesla_api = TeslaApi::Client.new(ENV['TESLA_EMAIL'], ENV['TESLA_CLIENT_ID'], ENV['TESLA_CLIENT_SECRET'])
      token = $redis.cache('tesla-token', 1.hour.to_i) do
        puts 'Logging into Tesla API...'
        tesla_api.login!(ENV['TESLA_PASS'])
        tesla_api.token
      end
      tesla_api.token = token
      puts "Logged in as #{ENV['TESLA_EMAIL']}!"
      tesla_api
    end
  end

  def car
    @car ||= tesla_api.vehicles.find { |v| v.vin == ENV['TESLA_VIN'] }
  end

  def write_to_influxdb(state)
    state[:time] = state[:time].to_i
    $influxdb.write_point('telematics', { values: state })
  end

  def write_to_socket(state)
    HTTParty.post(ENV['TRIP_URL'], body: state.to_json)
  rescue
    puts "Websocket error: #{$!}"
  end
end
