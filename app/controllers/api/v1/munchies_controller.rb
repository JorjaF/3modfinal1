module Api
  module V1
    class MunchiesController < ApplicationController
      def index
        location = params[:location]
        forecast = WeatherApiFacade.one_day_forecast(location)
        food = params[:food]
      end
    end
  end
end
