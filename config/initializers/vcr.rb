require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock # use webmock for hooking into HTTP requests
  config.configure_rspec_metadata!
  config.ignore_localhost = true

  config.filter_sensitive_data('<API_KEY>') { ENV['OPEN_WEATHER_API_KEY'] }
end