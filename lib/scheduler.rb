if Time.parse(ENV['START_TIME']) < Time.now && Time.parse(ENV['END_TIME']) > Time.now
  Rails.logger.info 'Starting scheduler...'
  scheduler = Rufus::Scheduler::singleton

  scheduler.every '1m' do
    Rails.logger.info 'Refresh Telemetry Cache'
    require_relative 'influxdb_data'
    ::DataCache.telemetry
  end

  scheduler.every '40s' do
    Rails.logger.info 'Refresh Car State Cache'
    ::DataCache.state
  end

  scheduler.join unless ENV.fetch('INLINE_SCHEDULER', 'true') == 'true'
end
