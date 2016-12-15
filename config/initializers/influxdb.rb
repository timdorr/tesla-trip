$influxdb = InfluxDB::Client.new(
    ENV['INFLUX_DATABASE'],
    host: ENV['INFLUX_HOST'],
    username: ENV['INFLUX_USER'],
    password: ENV['INFLUX_PASS']
)
