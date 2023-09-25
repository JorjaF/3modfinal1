class WeatherApiFacade
  require 'json'
  require 'net/http'

  API_KEY = ENV['WEATHER_API_KEY']
  BASE_URL = 'http://api.weatherapi.com/v1'

  def self.current_weather(location)
    response = get_response(location)
  end

  def self.get_response(location)
    uri = URI("#{BASE_URL}/current.json?key=#{API_KEY}&q=#{location}")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body, symbolize_names: true)
  rescue StandardError => e
    Rails.logger.error("Error fetching weather data: #{e.message}")
    nil
  end

  def self.fetch_daily_weather(location, days)
    uri = URI("#{BASE_URL}/forecast.json?key=#{API_KEY}&q=#{location}&days=#{days}&aqi=no&alerts=no")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body, symbolize_names: true)
  rescue StandardError => e
    Rails.logger.error("Error fetching weather data: #{e.message}")
  end
end
