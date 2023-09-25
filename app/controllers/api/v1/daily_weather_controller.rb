module Api
  module V1
    class DailyWeatherController < ApplicationController
      def index
        location = params[:location]

        @daily_weather = WeatherApiFacade.fetch_daily_weather(location, days: 5)

        if @daily_weather
          render json: @daily_weather
        else
          render json: { error: "Unable to fetch 5-day weather forecast"}, status: :unprocessable_entity
        end
      end
    end
  end
end
