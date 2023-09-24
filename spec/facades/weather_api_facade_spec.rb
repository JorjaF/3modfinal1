require "rails_helper"

RSpec.describe "Weather Forecast API", type: :request do
  describe "#current_weather" do
    it "returns weather data for a given location, in the expected structure" do
      location = "Denver,CO"
      details = WeatherApiFacade.current_weather(location)
      

      expect(details).to be_a(Hash)
      expect(details).to have_key(:location)
    end
  end
end
