module Api
  module V1
    class FiveDayForecastController < ApplicationController
      def index
        location = params[:location]

        forecast = WeatherApiFacade.five_day_forecast(location, 5)

        if forecast
          render json: FiveDayForecastSerializer.new(forecast)
        else
          render json: { error: "Unable to fetch 5-day weather forecast"}, status: :unprocessable_entity
        end
      end
    end
  end
end
