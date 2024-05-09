module WeatherService
  class Response
    attr_accessor :temperature
    attr_accessor :min_temperature
    attr_accessor :max_temperature
    attr_writer :cached

    def cached?
      @cached
    end
  end
end