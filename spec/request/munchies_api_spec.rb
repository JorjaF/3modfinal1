require 'rails_helper'

RSpec.describe "Munchies API", type: :request do
  describe "GET /api/v1/munchies" do
    let(:destination) { "pueblo,co" }
      let(:food) { "italian" }

      before do
        stub_request(:get, "http://api.weatherapi.com/v1/current.json?key=552cd5f4299349deb83155448232409&q=pueblo,co")
        .to_return(status: 200, body: File.read("spec/fixtures/one_day_forecast_response.json"))

        
        allow(WeatherService).to receive(:get_forecast).with(destination).and_return({
          summary: "Cloudy with a chance of meatballs",
          temperature: 83
        })

        allow(YelpService).to receive(:find_restaurant).with(destination, food).and_return({
          name: "La Forchetta Da Massi",
          address: "126 S Union Ave, Pueblo, CO 81003",
          rating: 4.5,
          reviews: 148
        })

        # Perform the API request
        get "/api/v1/munchies?destination=#{destination}&food=#{food}"
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the expected JSON response" do
        expected_response = {
          "data" => {
            "id" => "null",
            "type" => "munchie",
            "attributes" => {
              "destination_city" => "Pueblo, CO",
              "forecast" => {
                "summary" => "Cloudy with a chance of meatballs",
                "temperature" => "83"
              },
              "restaurant" => {
                "name" => "La Forchetta Da Massi",
                "address" => "126 S Union Ave, Pueblo, CO 81003",
                "rating" => 4.5,
                "reviews" => 148
              }
            }
          }
        }

        expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end
end
