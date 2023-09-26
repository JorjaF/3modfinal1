module Api
  module V1
    class OneDayForecastController < ApplicationController
      def index
        
        location = params[:location]

        forecast = WeatherApiFacade.one_day_forecast(location)
        if forecast
          render json: ForecastSerializer.new(forecast)
        else
          render json: { error: "Unable to fetch forecast" }, status: :unprocessable_entity
        end
      end
    end
  end
end
