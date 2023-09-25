require "rails_helper"

RSpec.describe "Weather Forecast API", type: :request do
  describe "GET /api/v1/forecast/:location" do
    it "returns a JSON response with the expected formated data" do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to have_http_status(:ok)
      
      json_response = JSON.parse(response.body)

      expect(json_response).to include(
        {
          "data" => {
            "id" => nil, 
            "type" => "forecast", 
            "attributes" => {
              "location" => "Denver, CO", 
              "last_updated" => "2021-10-05 21:00", 
              "temperature" => 65.0, 
              "feels_like" => 65.0, 
              "humidity" => 65.0, 
              "uvi" => 3.5, 
              "visibility" => 10.0, 
              "condition" => "Partly Cloudy", 
              "icon" => "partlycloudy.png"
            }
          }
        }
      )
    end

    # it it "fetches and returns a 5-day weather forecast" do
    #   get "/api/v1/daily_weather?location=denver,co?days=5" 

    #   expect(response).to have_http_status(:ok)
    #   json_response = JSON.parse(response.body)
    #   daily_weather = json_response

    #     expect(daily_weather.count).to eq(5)

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
