namespace :tesla do
  desc "Refreshes the telemetry cache"
  task refresh_telemetry: :environment do
    DataCache.telemetry
  end

  desc "Refreshes the state data cache"
  task refresh_state: :environment do
    DataCache.state
  end
end