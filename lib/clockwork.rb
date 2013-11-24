require 'clockwork'
require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(1.minute,   'Refresh Telemetry Cache') { DataCache.telemetry }
  every(15.seconds, 'Refresh Car State Cache') { DataCache.state }
end