class InfluxdbData
  def telematics(start, stop = Time.now)
    puts "time > #{start.to_i}s AND time < #{stop.to_i}s"
    @telemetry ||= $influxdb.query("
      SELECT #{select_fields}
      FROM telematics
      WHERE time > #{start.to_i}s AND time < #{stop.to_i}s
      GROUP BY time(1m)"
    )["telematics"]
  end

  private

  def select_fields
    series_keys.map{|k| "MEAN(#{k}) AS #{k}" }.join(", ")
  end

  def series_keys
    %w(odometer speed est_lat est_lng soc power)
  end
end
