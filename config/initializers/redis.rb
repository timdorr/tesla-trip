if ENV['REDIS_URL']
  $redis = Redis.new

  # Monkey patch in caching for Redis
  class Redis
    def cache(key, expire=nil, recalculate=false)
      if (value = get(key)).nil? || recalculate
        value = yield(self)
        set(key, value)
        expire(key, expire) if expire
        value
      else
        value
      end
    end
  end
end
