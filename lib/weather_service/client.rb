module WeatherService
  module Client
    class Error < StandardError; end

    class << self
      def current(zip)
        api_response = api_client.current_zip(zip, 'US')
        WeatherService::Response.new(api_response)
      rescue Exception => e
        raise Error.new(e.message)
      end

      private

      def api_client
        @api_client ||= OpenWeather::Client.new
      end
    end
  end
end