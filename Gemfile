source 'https://rubygems.org'

ruby '2.7.2'

gem 'rails', '~> 7.0.4'

# System
gem 'warning'
gem 'bootsnap'
gem 'dotenv-rails'

# Backend
gem 'pg'
gem 'influxdb'
gem 'hiredis'
gem 'redis', require: %w(redis redis/connection/hiredis)
gem 'puma'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.8.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'awesome_print'
end

# JSON
gem 'oj'
gem 'responders'

# Tesla
gem 'tesla_api'

# Jerbs
gem 'rufus-scheduler'

# Google
gem 'polylines'
gem 'simplify_rb'

# Sockets
gem 'faye-websocket', '~> 0.11'
