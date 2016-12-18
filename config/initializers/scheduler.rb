Rails.logger.info 'Starting scheduler...'
scheduler = Rufus::Scheduler::singleton

scheduler.every '1m' do
  Rails.logger.info 'Refresh Telemetry Cache'
  require_relative '../../lib/data_cache'
  ::DataCache.telemetry
end

scheduler.every '40s' do
  Rails.logger.info 'Refresh Car State Cache'
  require_relative '../../lib/data_cache'
  ::DataCache.state
end
