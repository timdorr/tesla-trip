namespace :tesla do
  desc "Streams telemetry data to Tempo DB"
  task stream: :environment do
    puts "Loading up Tesla API Streamer..."

    reader = TeslaStreamReader.new(ENV['TESLA_EMAIL'], ENV['TESLA_PASS'])
    reader.stream_to_tempodb
  end
end