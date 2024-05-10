# README

![Demo Animation](https://github.com/pcunnane/weather_forecast/assets/35730/a2f4f986-ec85-4903-a94a-6abab0e3ba8f?raw=true)
## Overview


## Assumptions and Choices
  * Address Input - The project outline required receiving an address as input from the user. Rather than having a form with separate fields for the different address components, I decided that the best user experience would be to provide a single text field for the address. Similar to how other weather applications function, I wanted to provide autocomplete functionality. By using the Google Maps API, I was able to do this while also providing correct city, state and zipcode values for the weather API.
  * Caching by Zipcode - The project outline also required caching the weather report results for 30 minutes by zipcode. I chose to not require the user to enter a zipcode in order to receive a weather report. Instead, I'm relying on the Google Address Autocompleter to return the zipcode for a given address. There are cities in the US that have multiple zipcodes assigned to them, and in that case a zipcode is not returned by the autocompleter. In these cases I am looking up weather data base on the city and state values. Therefore, weather lookups are cached either by zipcode if available, otherwise by city and state, for 30 minutes.

## Weather Service Objects
  * The external weather service for retrieving weather data is the [Open Weather API](https://openweathermap.org/api). I chose to wrap this service in a module to make it easy to switch out external services in the future if required.
```
  # This is the wrapper class that provides weather report data by zipcode or city and state
  WeatherService::Client

  # It returns a response object (WeatherService::Response) that has the weather report details
  2.5.5 :002 > y WeatherService::Client.current_by_zipcode(96150)
--- !ruby/object:WeatherService::Response
temperature: 56.19
min_temperature: 50.79
max_temperature: 60.6
cached: true

  # In the case that the service is unavailable, a internal exception is raised.
  WeatherService::Client::Error

```
## External Services


## Caching
  * The caching of weather data is currently being handled by the Rails in-memory cache `:mem_store`. In a production environment this would have several drawbacks, particularly as traffic grows. If a Redis instance were available in production I would add the Redis gem to this project and configure the Rails cache to use it as the cache backend.