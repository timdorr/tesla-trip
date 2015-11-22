namespace :tesla do
  desc "Refreshes the telemetry cache"
  task refresh_telemetry: :environment do
    DataCache.telemetry
  end

  desc "Refreshes the state data cache"
  task refresh_state: :environment do
    DataCache.state
  end

  desc "Streams telemetry to the datastore"
  task stream: :environment do
    puts "Loading up Tesla API Streamer..."
    TeslaStreamReader.new.stream_to_influxdb
  end
end
