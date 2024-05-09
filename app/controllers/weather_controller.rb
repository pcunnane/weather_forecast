class WeatherController < ApplicationController
  def index
  end

  def show
    @address = params[:address]
    @zipcode = params[:zipcode]
    @weather = WeatherService::Client.current(@zipcode)
  end
end
