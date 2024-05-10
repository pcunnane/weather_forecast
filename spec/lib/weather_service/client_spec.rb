require 'rails_helper'
require 'weather_service/client'

RSpec.describe WeatherService::Client, :vcr do
  describe '.current_by_zipcode' do
    let(:zipcode) { '93907' }

    before do
      Rails.cache.clear
    end

    it 'retrieves current weather data for a given zipcode' do
      response = WeatherService::Client.current_by_zipcode(zipcode)

      expect(response.temperature).to be_a(Float)
      expect(response.min_temperature).to be_a(Float)
      expect(response.max_temperature).to be_a(Float)
      expect(response.cached?).to be_falsey
    end

    it 'caches the result and sets the cached attribute' do
      # First call to cache the result
      WeatherService::Client.current_by_zipcode(zipcode)

      response = WeatherService::Client.current_by_zipcode(zipcode)
      expect(response.cached?).to be_truthy
    end

    it 'raises an error when the api request fails' do
      allow_any_instance_of(OpenWeather::Client)
        .to receive(:current_zip)
        .and_raise(Net::ReadTimeout)

      expect {
        WeatherService::Client.current_by_zipcode(zipcode)
      }.to raise_error(WeatherService::Client::Error)
    end
  end

  describe '.current_by_city_state' do
    let(:city) { 'South Lake Tahoe' }
    let(:state) { 'CA' }

    before do
      Rails.cache.clear
    end

    it 'retrieves current weather data for a given city and state' do
      response = WeatherService::Client.current_by_city_state(city, state)

      expect(response.temperature).to be_a(Float)
      expect(response.min_temperature).to be_a(Float)
      expect(response.max_temperature).to be_a(Float)
      expect(response.cached?).to be_falsey
    end

    it 'caches the result and sets the cached attribute' do
      # First call to cache the result
      WeatherService::Client.current_by_city_state(city, state)

      response = WeatherService::Client.current_by_city_state(city, state)
      expect(response.cached?).to be_truthy
    end

    it 'raises an error when the api request fails' do
      allow_any_instance_of(OpenWeather::Client)
        .to receive(:current_city)
        .and_raise(Net::ReadTimeout)

      expect {
        WeatherService::Client.current_by_city_state(city, state)
      }.to raise_error(WeatherService::Client::Error)
    end
  end
end
