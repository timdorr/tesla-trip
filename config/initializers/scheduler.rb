Rails.logger.info 'Starting scheduler...'
scheduler = Rufus::Scheduler::singleton

scheduler.every '1m' do
  Rails.logger.info 'Refresh Telemetry Cache'
  ::DataCache.telemetry
end

scheduler.every '40s' do
  Rails.logger.info 'Refresh Car State Cache'
  ::DataCache.state
end
