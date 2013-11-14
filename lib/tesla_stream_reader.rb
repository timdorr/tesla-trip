class TeslaStreamReader
  def initialize(email, password)
    @tesla_api = TeslaApi.new(email, password)
  end

  def stream_to_tempodb
    loop do
      @tesla_api.vehicles.first.wake_up
      car = @tesla_api.vehicles.first

      car.stream do |state|
        data = []
        state.except(:time).each do |key, value|
          data << { key: key, v: value.to_f }
        end

        puts state.inspect
        $tempodb.write_bulk(state[:time], data)
      end
    end
  end
end