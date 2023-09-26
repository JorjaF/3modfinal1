require 'rails_helper'
require 'webmock/rspec'
require 'net/http'
require 'uri'
require 'json'

RSpec.describe "Munchies API", type: :request do
  describe "GET /api/v1/munchies" do
    let(:destination) { "pueblo,co" }
    let(:food) { "italian" }

    before do
      stub_request(:get, /api.weatherapi.com\/v1\/current.json/)
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host' => 'api.weatherapi.com',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: "", headers: {})
            
      stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&sort_by=best_match")
        .with(
          headers: {
            'Accept' => 'application/json',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer YOUR_YELP_API_KEY',
            'Host' => 'api.yelp.com',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: "", headers: {})
    end

    it "returns a successful response from Yelp API" do
      url = URI.parse("https://api.yelp.com/v3/businesses/search?sort_by=best_match&limit=20")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer YOUR_YELP_API_KEY" 

      response = http.request(request)

      expect(response.code.to_i).to eq(200)
    end

    it "returns the expected JSON response from Yelp API" do
      stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&sort_by=best_match")
        .with(
          headers: {
            'Accept' => 'application/json',
            'Authorization' => "Bearer #{Rails.application.credentials.yelp_api_key}",
          }
        )
        .to_return(
          status: 200,
          body: File.read("spec/fixtures/munchies_response.json"),
          headers: { 'Content-Type' => 'application/json' }
        )

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
      yelp_response_body = File.read("spec/fixtures/munchies_response.json")

      expect(JSON.parse(yelp_response_body)).to eq(expected_response)
    end
  end
end
