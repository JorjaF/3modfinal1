require 'rails_helper'
require 'webmock/rspec'
require 'net/http' 

RSpec.describe "Munchies API", type: :request do
  describe "GET /api/v1/munchies" do
    let(:destination) { "pueblo,co" }
    let(:food) { "italian" }

    before do
      stub_request(:get, "http://api.weatherapi.com/v1/current.json?key=552cd5f4299349deb83155448232409&q=")
        .with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host'=>'api.weatherapi.com',
            'User-Agent'=>'Ruby'
          })
        .to_return(status: 200, body: "", headers: {})

      stub_request(:get, "http://api.weatherapi.com/v1/current.json?key=552cd5f4299349deb83155448232409&q=pueblo,co")

      stub_request(:get, "https://api.yelp.com/v3/businesses/search?sort_by=best_match&limit=20")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      
      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      
      response = http.request(request)
      puts response.read_body

      uri = URI("https://api.yelp.com/v3/businesses/search")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri)
      response = http.request(request)
      @yelp_response_body = response.body # Capture the response body
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

      expect(JSON.parse(@yelp_response_body)).to eq(expected_response)
    end
  end
end
