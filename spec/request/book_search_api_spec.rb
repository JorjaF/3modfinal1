# require "rails_helper"
# require 'webmock/rspec'

# RSpec.describe "BookSearch API", type: :request do
#   describe "GET /api/v1/book-search" do
#     context "with valid parameters" do
#       let(:location) { "Denver, CO" }
#       let(:quantity) { 5 }

#       before do
#         stub_request(:get, "http://api.weatherapi.com/v1/current.json?key=552cd5f4299349deb83155448232409&q=Denver,CO")
#         .with(
#           headers: {
#         'Accept'=>'*/*',
#         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
#         'Host'=>'api.weatherapi.com',
#         'User-Agent'=>'Ruby'
#           }).
#         to_return(status: 200, body: "", headers: {})
        
#         stub_request(:get, "https://openlibrary.org/search.json?q=#{location}&page=#{quantity}")
#           .to_return(status: 200, body: {}.to_json) 
        
#         get "/api/v1/book-search", params: { location: location, quantity: quantity }
#       end

#       it "returns a successful response" do
#         expect(response).to have_http_status(200)
#       end

#     #   it "returns the destination city" do
#     #     expect(json_response["destination_city"]).to eq(location)
#     #   end

#     #   it "returns the forecast in that city" do
#     #     expect(json_response["forecast"]).to_not be_empty
#     #   end

#     #   it "returns the total number of search results found" do
#     #     expect(json_response["total_results"]).to be_an(Integer)
#     #   end

#     #   it "returns a quantity of books about the destination city" do
#     #     expect(json_response["books"]).to be_an(Array)
#     #     expect(json_response["books"].count).to eq(quantity)
#     #   end
#     # end

#     # context "with invalid parameters" do
#     #   it "returns a 400 Bad Request status when quantity is missing" do
#     #     get "/api/v1/book-search", params: { location: "denver,co" }
#     #     expect(response).to have_http_status(400)
#     #   end

#     #   it "returns a 400 Bad Request status when quantity is not a positive integer" do
#     #     get "/api/v1/book-search", params: { location: "denver,co", quantity: -5 }
#     #     expect(response).to have_http_status(400)
#     #   end
#     end
#   end
# end
