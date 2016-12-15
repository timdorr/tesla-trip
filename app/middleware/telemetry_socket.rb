require 'faye/websocket'

module TeslaTrip
  class TelemetrySocket
    KEEPALIVE_TIME = 15
    CHANNEL = 'tesla-websocket'

    def initialize(app)
      @app = app
      @clients = []

      Thread.new do
        uri = URI.parse(ENV['REDIS_URL'])
        redis_sub = Redis.new(host: uri.host, port: uri.port, password: uri.password)
        redis_sub.subscribe(CHANNEL) do |on|
          on.message do |channel, msg|
            @clients.each { |ws| ws.send(msg) }
          end
        end
      end
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME})
        ws.on :open do |event|
          @clients << ws
        end

        ws.on :close do |event|
          @clients.delete(ws)
          ws = nil
        end

        # Return async Rack response
        ws.rack_response
      else
        @app.call(env)
      end
    end

    private

    def sanitize(message)
      json = JSON.parse(message)
      json.each { |key, value| json[key] = ERB::Util.html_escape(value) }
      JSON.generate(json)
    end
  end
end
