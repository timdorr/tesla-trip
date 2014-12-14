class InfluxdbData
  def telematics(start, stop = Time.now)
    @telemetry ||= $influxdb.query("SELECT * FROM telematics WHERE time > '#{start.strftime("%Y-%m-%d %H:%M:%S")}' AND time < '#{stop.strftime("%Y-%m-%d %H:%M:%S")}'")["telematics"]
  end

  def series_keys
    %w(odometer speed est_lat est_lng soc power)
  end
end
