require "rails_helper"

RSpec.describe "Weather Forecast API", type: :request do
  describe "GET /api/v1/forecast/:location" do
    it "returns a JSON response with the expected formated data" do
      get "/api/v1/forecast?location=cincinnati,oh"

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
  end
end
