require 'rails_helper'

RSpec.describe ForecastSerializer, type: :serializer do
  let(:weather_data) do
    {
      location: {
        name: "Denver",
        region: "Colorado",
        # country: "United States of America",
        # lat: 39.74,
        # lon: -104.98,
        # tz_id: "America/Denver",
        # localtime: "2023-09-24 15:34"
      },
      current: {
        last_updated: "2023-09-24 15:30",
        temp_c: 24.8,
        temp_f: 76.6,
        is_day: 1,
        condition: {
          text: "Partly cloudy",
          icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
          code: 1003
        },
        wind_mph: 6.9,
        wind_kph: 11.2,
        wind_degree: 350,
        wind_dir: "N",
        pressure_mb: 1020.0,
        pressure_in: 30.13,
        precip_mm: 0.0,
        precip_in: 0.0,
        humidity: 6,
        cloud: 25,
        feelslike_c: 23.7,
        feelslike_f: 74.6,
        vis_km: 16.0,
        vis_miles: 9.0,
        uv: 7.0,
        gust_mph: 5.4,
        gust_kph: 8.7,
      },
    id: nil
    }
  end

  let(:serializer) { ForecastSerializer.new(weather_data) }

  it 'serializes the weather data correctly' do
  
    serialized_data = serializer.serializable_hash

  
    serialized_data[:data].delete(:id)

    expect(serialized_data[:data][:type]).to eq(:forecast)
    expect(serialized_data[:data][:attributes][:location]).to eq(weather_data[:location])
    expect(serialized_data[:data][:attributes][:id]).to eq(nil)
    expect(serialized_data[:data][:attributes][:current][:last_updated]).to eq(weather_data[:current][:last_updated])
    expect(serialized_data[:data][:attributes][:current][:temperature]).to eq(weather_data[:current][:temp_f])
    expect(serialized_data[:data][:attributes][:current][:feels_like]).to eq(weather_data[:current][:feelslike_f])
    expect(serialized_data[:data][:attributes][:current][:humidity]).to eq(weather_data[:current][:humidity])
    expect(serialized_data[:data][:attributes][:current][:uvi]).to eq(weather_data[:current][:uv])
    expect(serialized_data[:data][:attributes][:current][:visibility]).to eq(weather_data[:current][:vis_miles])
    expect(serialized_data[:data][:attributes][:current][:condition][:text]).to eq(weather_data[:current][:condition][:text])
    expect(serialized_data[:data][:attributes][:current][:condition][:icon]).to eq(weather_data[:current][:condition][:icon])
  end
end
