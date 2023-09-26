require "rails_helper"
require "webmock/rspec"

RSpec.describe "Weather Forecast API", type: :request do
  before do
    stub_request(:get, /api.weatherapi.com\/v1/)
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host' => 'api.weatherapi.com',
          'User-Agent' => 'Ruby'
        }
      ).to_return(status: 200, body: "")
  end

  describe "GET /api/v1/forecast/:location" do

    it "returns a JSON response with the expected formatted data" do
    
      stub_request(:get, "http://api.weatherapi.com/v1/current.json?key=552cd5f4299349deb83155448232409&q=denver,co")
        .to_return(status: 200, body: File.read("spec/fixtures/one_day_forecast_response.json"))

      get "/api/v1/one_day_forecast?location=denver,co"

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      
      expect(json_response).to include(
  {
    "data" => {
      "id" => nil,
      "type" => "forecast",
      "attributes" => {
        "current" => {
          "last_updated" => "2023-09-25 17:30",
          "temperature" => 81.3,
          "feels_like" => 78.0,
          "humidity" => 8,
          "uvi" => 7.0,
          "visibility" => 9.0,
          "condition" => "Partly cloudy",
          "icon" => "//cdn.weatherapi.com/weather/64x64/day/116.png"
        },
        "location" => {
          "name" => "Denver",
          "region" => "Colorado"
        }

      }
    }
  }
)
end


    # it "fetches and returns a 5-day weather forecast" do
    #   body = File.read("spec/fixtures/5_day_forecast_response.json")
    #   stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=552cd5f4299349deb83155448232409&q=denver,co&days=5&aqi=no&alerts=no")
    #     .to_return(status: 200, body: body)

    #   get "/api/v1/five_day_forecast?location=denver,co&days=5"

    #   expect(response).to have_http_status(:ok)
    #   json_response = JSON.parse(response.body)
      
    #   require 'pry'; binding.pry
    #   daily_weather = json_response["data"]["attributes"]["daily_weather"]
    #   expect(daily_weather.count).to eq(5)
    #   daily_weather.each do |day|
    #     expect(day["date"]).to match(/\d{4}-\d{2}-\d{2}/)
    #     expect(day["sunrise"]).to match(/\d{2}:\d{2}/)
    #     expect(day["sunset"]).to match(/\d{2}:\d{2}/)
    #     expect(day["max_temp"]).to be_a(Float)
    #     expect(day["min_temp"]).to be_a(Float)
    #     expect(day["conditions"]).to be_a(String)
    #     expect(day["icon"]).to be_a(String)
    #   end
    # end
  end
end
