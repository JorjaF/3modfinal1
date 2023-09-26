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

    it "fetches and returns a 5-day weather forecast" do
      body = File.read("spec/fixtures/5_day_forecast_response.json")
      stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=552cd5f4299349deb83155448232409&q=denver,co&days=5&aqi=no&alerts=no")
        .to_return(status: 200, body: body)
    
      get "/api/v1/five_day_forecast?location=denver,co&days=5"
    
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)

      expect(json_response).to have_key("data")
      expect(json_response["data"]).to have_key("attributes")
      
    
      expected_data = {
        "data" => [
          {
            "date" => "2023-09-26",
            "sunrise" => "06:30",
            "sunset" => "18:45", # Updated sunset time
            "max_temp" => 75.0,
            "min_temp" => 55.0,
            "conditions" => "Sunny", # Updated conditions
            "icon" => "sunny.png"
          },
          {
            "date" => "2023-09-27",
            "sunrise" => "06:31",
            "sunset" => "18:43",
            "max_temp" => 78.0,
            "min_temp" => 58.0,
            "conditions" => "Partly Cloudy", # Updated conditions
            "icon" => "partlycloudy.png"
          },
          {
            "date" => "2023-09-28",
            "sunrise" => "06:32",
            "sunset" => "18:41", # Updated sunset time
            "max_temp" => 80.0,
            "min_temp" => 60.0,
            "conditions" => "Partly Cloudy", # Updated conditions
            "icon" => "partlycloudy.png"
          },
          {
            "date" => "2023-09-29",
            "sunrise" => "06:33",
            "sunset" => "18:39",
            "max_temp" => 82.0,
            "min_temp" => 62.0,
            "conditions" => "Partly Cloudy", # Updated conditions
            "icon" => "partlycloudy.png"
          },
          {
            "date" => "2023-09-30",
            "sunrise" => "06:34",
            "sunset" => "18:37",
            "max_temp" => 84.0,
            "min_temp" => 64.0,
            "conditions" => "Partly Cloudy", # Updated conditions
            "icon" => "partlycloudy.png"
          }
        ]
      }
      
      expect(json_response["data"]["attributes"]).to eq(expected_data)
    end
  end
end
    