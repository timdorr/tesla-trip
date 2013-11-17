class TempodbData
  def initialize(start, stop = Time.now)
    @data = []
    tempo_data = $tempodb.read(start, stop, keys: series_keys)

    tempo_data = Hash[tempo_data.map{|set| [set.series.key.to_sym, set.data]}]

    tempo_data[:odometer].each_with_index do |data, index|
      @data[index] = {
          ts: data.ts,
          lat:      tempo_data[:est_lat ][index].value,
          lng:      tempo_data[:est_lng ][index].value,
          odometer: tempo_data[:odometer][index].value,
          speed:    tempo_data[:speed   ][index].value,
          soc:      tempo_data[:soc     ][index].value,
          power:    tempo_data[:power   ][index].value
      }
    end

    @data.reverse!
  end

  private

  def series_keys
    %w(odometer speed est_lat est_lng soc power)
  end
end