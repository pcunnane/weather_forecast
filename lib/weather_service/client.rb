module WeatherService
  module Client
    class Error < StandardError; end

    CACHE_TIME = 30.minutes

    class << self
      def current_by_zipcode(zipcode)
        cached(zipcode) do
          api_response = api_client.current_zip(zipcode, 'US')
          create_response(api_response)
        end
      rescue Exception => e
        raise Error.new(e.message)
      end

      def current_by_city_state(city, state)
        cached(city + state) do
          api_response = api_client.current_city(city, state, 'US')
          create_response(api_response)
        end
      rescue Exception => e
        raise Error.new(e.message)
      end

      private

      def api_client
        @api_client ||= OpenWeather::Client.new
      end

      def cached(key)
        key = "weather_for_#{key}"
        response = Rails.cache.read(key)
        if response
          response.cached = true
          return response
        end

        response = yield
        Rails.cache.write(key, response, expires_in: CACHE_TIME)
        response
      end

      def create_response(api_response)
        response = WeatherService::Response.new
        response.temperature = api_response.main.temp
        response.min_temperature = api_response.main.temp_min
        response.max_temperature = api_response.main.temp_max
        response
      end
    end
  end
end