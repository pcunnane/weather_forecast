require 'rails_helper'
require 'weather_service/client'

RSpec.describe WeatherService::Client, :vcr do
  describe '.current_by_zipcode' do
    it 'retrieves current weather data for a given zipcode' do
      zipcode = '93907'
      response = WeatherService::Client.current_by_zipcode(zipcode)

      expect(response.temperature).to be_a(Float)
      expect(response.min_temperature).to be_a(Float)
      expect(response.max_temperature).to be_a(Float)
    end
  end
end
