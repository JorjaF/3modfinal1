class Forecast < ApplicationRecord
  def as_json_forecast
  {
    last_updated: last_updated.strftime('%Y-%m-%d %H:%M'),
    temperature: temperature.to_f,
    feels_like: feels_like.to_f,
    humidity: humidity.to_f,
    uvi: uvi.to_f,
    visibility: visibility.to_f,
    condition: condition,
    icon: icon
  }
end
end
