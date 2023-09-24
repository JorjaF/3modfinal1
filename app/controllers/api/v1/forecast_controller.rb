module Api
  module V1
    class ForecastController < ApplicationController
      def index
        forecast_data = {data: {id: nil, type: "forecast", attributes: {location: "Denver, CO", last_updated: "2021-10-05 21:00", temperature: 65.0, feels_like: 65.0, humidity: 65.0, uvi: 3.5, visibility: 10.0, condition: "Partly Cloudy", icon: "partlycloudy.png"}}}
        render json: forecast_data, meta: { id: nil }
      end
    end
  end
end
