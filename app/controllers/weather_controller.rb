class WeatherController < ApplicationController
  def index
  end

  def show
    @address = params[:address]
    @zipcode = params[:zipcode]
    @city = params[:city]
    @state = params[:state]

    if @zipcode.present?
      @weather = WeatherService::Client.current_by_zipcode(@zipcode)
    elsif @city.present? && @state.present?
      @weather = WeatherService::Client.current_by_city_state(@city, @state)
    else
      render_error
    end

    respond_to do |format|
      format.html
      format.js
    end
  rescue WeatherService::Client::Error
    render_error
  end

  private

  def render_error
    @error = 'Unable to retrieve a weather forecast at this time.'
  end
end
