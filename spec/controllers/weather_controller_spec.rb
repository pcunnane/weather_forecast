require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  describe 'POST #show' do
    context 'with valid zipcode' do
      let(:zipcode) { '96150' }
      let(:address) { 'South Lake Tahoe, CA' }

      let(:weather_response) {
        double('WeatherService::Response', {
          temperature: 55.0,
          max_temperature: 66.0,
          min_temperature: 52.0,
          cached: false
        })
      }

      before do
        allow(WeatherService::Client).to receive(:current_by_zipcode).with(zipcode).and_return(weather_response)
      end

      it 'assigns @weather and @address' do
        post :show, params: { zipcode: zipcode, address: address }
        expect(assigns(:weather)).to eq(weather_response)
        expect(assigns(:address)).to eq(address)
      end

      it 'renders the show template' do
        post :show, params: { zipcode: zipcode, address: address }
        expect(response).to render_template(:show)
      end
    end

    context 'with valid city and state' do
      let(:address) { 'South Lake Tahoe, CA' }
      let(:city) { 'South Lake Tahoe' }
      let(:state) { 'CA' }

      let(:weather_response) {
        double('WeatherService::Response', {
          temperature: 55.0,
          max_temperature: 66.0,
          min_temperature: 52.0,
          cached: false
        })
      }

      before do
        allow(WeatherService::Client).to receive(:current_by_city_state).with(city, state).and_return(weather_response)
      end

      it 'assigns @weather and @address' do
        post :show, params: { city: city, state: state, address: address }
        expect(assigns(:weather)).to eq(weather_response)
        expect(assigns(:address)).to eq(address)

      end

      it 'renders the show template' do
        post :show, params: { city: city, state: state, address: address }
        expect(response).to render_template(:show)
      end
    end

    context 'without invalid data' do
      let(:address) { 'South Lake Tahoe, CA' }
      let(:city) { '' }
      let(:state) { '' }
      let(:zipcode) { '' }

      before do
        allow(WeatherService::Client).to receive(:current_by_city_state).with(city, state).and_raise(WeatherService::Client::Error)
      end

      it 'assigns @error' do
        post :show, params: { city: city, state: state, zipcode: zipcode, address: address }
        expect(assigns(:error)).to eq('Unable to retrieve a weather forecast at this time.')
      end

      it 'renders the show template' do
        post :show, params: { city: city, state: state, zipcode: zipcode, address: address }
        expect(response).to render_template(:show)
      end
    end
  end
end
