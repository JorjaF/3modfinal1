require "rails_helper"
require "webmock/rspec"

RSpec.describe "Weather Forecast API", type: :request do
  before do
    body = File.read("spec/fixtures/one_day_forecast_response.json")

    stub_request(:get, "http://api.weatherapi.com/v1/current.json?key=552cd5f4299349deb83155448232409&q=Denver,CO")
      .with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host'=>'api.weatherapi.com',
          'User-Agent'=>'Ruby'
        }
      ).to_return(status: 200, body: body, headers: {})
  end

  describe "#current_weather" do
    it "returns weather data for a given location, in the expected structure" do
      location = "Denver,CO"
      details = WeatherApiFacade.current_weather(location)

      expect(details).to be_a(Hash)
      expect(details).to have_key(:location)
    end
  end
end
