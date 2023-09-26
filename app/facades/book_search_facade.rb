# class BookSearchFacade
#   require "net/http"
#   require "json"

#   def self.search(location, quantity)
#     base_url = Rails.configuration.open_library_base_url
#     open_library_data = fetch_open_library_data(location, quantity)
#     books = process_open_library_data(open_library_data)
    
#     API_KEY = ENV['WEATHER_API_KEY']
#     BASE_URL = 'http://api.weatherapi.com/v1'
#     weather_forecast = fetch_weather_forecast(location)

#     {
#       books: books,
#       weather_forecast: weather_forecast
#     }
#   end

#   def self.fetch_open_library_data(location, quantity)
#     base_url = Rails.configuration.open_library_base_url
#     api_url = "#{base_url}/search.json?q=#{location}&page=#{quantity}"
#     uri = URI(api_url)
#     response = Net::HTTP.get_response(uri)

#     if response.is_a?(Net::HTTPSuccess)
#       JSON.parse(response.body, symbolize_names: true)
#     else
#       Rails.logger.error("Error fetching Open Library data: #{response.body}")
#       return []
#     end
#   rescue StandardError => e
#     Rails.logger.error("Error fetching Open Library data: #{e.message}")
#     return []
#   end

#   def self.process_open_library_data(data)
#     if data.key?(:docs) && data[:docs].is_a?(Array)
#       books = data[:docs].map do |book_data|
#         location = book_data[:location]
#         quantity = book_data[:quantity]
#         total_results = book_data[:numFound]
#         {
#           location: location,
#           quantity: 5,
#           total_results: total_results
#         }
#       end
  
#       return books
#     else
#       Rails.logger.error("Invalid book data: #{data}")
#       return []
#     end

#   def self.fetch_weather_forecast(location)
#     uri = URI("#{BASE_URL}/current.json?key=#{API_KEY}&q=#{location}")
#     response = Net::HTTP.get_response(uri)
#     JSON.parse(response.body, symbolize_names: true)
#   rescue StandardError => e
#     Rails.logger.error("Error fetching weather data: #{e.message}")
#   end
# end
