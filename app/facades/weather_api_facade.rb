class WeatherApiFacade
  require 'json'
  require 'net/http'

  API_KEY = ENV['WEATHER_API_KEY']
  BASE_URL = 'http://api.weatherapi.com/v1'

  def self.current_weather(location)
    response = one_day_forecast(location)
  end

  def self.one_day_forecast(location)
    uri = URI("#{BASE_URL}/current.json?key=#{API_KEY}&q=#{location}")

    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.five_day_forecast(location, days)
    uri = URI("#{BASE_URL}/forecast.json?key=#{API_KEY}&q=#{location}&days=#{days}&aqi=no&alerts=no")

    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body, symbolize_names: true)
  end
end
