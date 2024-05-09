module WeatherService
  class Response
    attr_reader :temperature

    def initialize(response)
      @temperature = response.main.temp
    end
  end
end