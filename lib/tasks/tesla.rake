namespace :tesla do
  desc "Streams telemetry data to Tempo DB"
  task stream: :environment do
    reader = TeslaStreamReader.new(ENV['TESLA_EMAIL'], ENV['TESLA_PASS'])
    reader.stream_to_tempodb
  end
end