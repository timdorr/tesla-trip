if ENV["REDIS_URL"]
  uri = URI.parse(ENV["REDIS_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

  # Monkey patch in caching for Redis
  class Redis
    def cache(key, expire=nil, recalculate=false)
      if (value = get(key)).nil? || recalculate
        value = yield(self).to_json
        set(key, value)
        expire(key, expire) if expire
        JSON.parse(value)
      else
        JSON.parse(value)
      end
    end
  end
end