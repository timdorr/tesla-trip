class TeslaClient
  class << self
    def build
      client = TeslaApi::Client.new(
          email: ENV['TESLA_EMAIL'],
          **settings
      )

      if client.expired?
        settings.blank? ? client.login!(ENV['TESLA_PASS']) : client.refresh_access_token
        $redis.set(REDIS_KEY, to_settings(client))
      end

      client
    end

    REDIS_KEY = 'tesla-client'

    def settings
      JSON.parse($redis.get(REDIS_KEY) || '{}').symbolize_keys
    end

    def to_settings(client)
      {
          access_token: client.access_token,
          access_token_expires_at: client.access_token_expires_at,
          refresh_token: client.refresh_token,
      }.to_json
    end
  end
end
