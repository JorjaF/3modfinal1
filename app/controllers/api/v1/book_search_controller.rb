class Api::V1::BookSearchController < ApplicationController
  require "net/http"
  require "json"

  def search
    location = params[:location]
    quantity = params[:quantity].to_i
    response_data = BookSearchFacade.search(location, quantity)
    
    if quantity <= 0
      render json: { error: "Quantity must be a positive integer" }, status: :bad_request
      return
    end

    uri = URI("https://openlibrary.org/api/books.json?q=#{location}&limit=#{quantity}")
    response = Net::HTTP.get(uri)

    data = JSON.parse(response, symbolize_names: true)
    destination_city = location
    forecast = WeatherApiFacade.fetch_forecast(location)
    total_results = data[:numFound]
    books = data[:docs]

    response_data = {
      destination_city: destination_city,
      forecast: forecast,
      total_results: total_results,
      books: books
    }

    render json: response_data
  rescue JSON::ParserError
    render json: { error: "Invalid location" }, status: :bad_request
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
end
