class InfluxdbData
  def telematics(start, stop = Time.now)
    @telemetry ||= $influxdb.query("
      SELECT #{select_fields}
      FROM telematics
      WHERE time > #{start.to_i}s AND time < #{stop.to_i}s
      GROUP BY time(1m) fill(none)"
    ).first.try(:[], 'values')
  end

  def latest_state
    @latest ||= map_stream_to_state($influxdb.query('SELECT * FROM telematics LIMIT 1').first['values'].first)
  end

  private

  def select_fields
    series_keys.map{|k| "MEAN(#{k}) AS #{k}" }.join(", ")
  end

  def series_keys
    %w(odometer speed est_lat est_lng soc power)
  end

  def map_stream_to_state(stream)
    {
        'latitude' => stream['est_lat'],
        'longitude' => stream['est_lng'],
        'battery_level' => stream['soc'],
        'speed' => stream['speed']
    }
  end
end
