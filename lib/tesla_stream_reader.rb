class TeslaStreamReader
  def initialize(email, password)
    puts "Logging into Tesla API..."
    @tesla_api = TeslaApi.new(email, password)
    puts "Logged in as #{email}!"
  end

  def stream_to_tempodb
    loop do
      puts "Waking up car..."
      @tesla_api.vehicles.first.wake_up
      puts "Car awake!"
      car = @tesla_api.vehicles.first

      puts "Streaming car telematics..."
      car.stream do |state|
        puts "Received state: #{state.inspect}"

        data = []
        state.except(:time).each do |key, value|
          data << { key: key, v: value.to_f }
        end

        $tempodb.write_bulk(state[:time], data)
      end
      puts "Stream closed!"
    end
  end
end