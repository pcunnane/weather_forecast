OpenWeather::Client.configure do |config|
  config.api_key = ENV['OPEN_WEATHER_API_KEY']
  config.units = 'imperial'
end