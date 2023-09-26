class FiveDayForecastSerializer
  include JSONAPI::Serializer

  set_id { nil }

  attribute :location do |object|
    {
      name: object[:location][:name],
      region: object[:location][:region],
      country: object[:location][:country],
      lat: object[:location][:lat],
      lon: object[:location][:lon],
      tz_id: object[:location][:tz_id],
      localtime: object[:location][:localtime]
    }
  end

  attribute :daily_weather do |object|
    object[:daily_weather].map do |day|
      {
        date: day[:date],
        sunrise: day[:sunrise],
        sunset: day[:sunset],
        max_temp: day[:max_temp],
        min_temp: day[:min_temp],
        conditions: day[:conditions],
        icon: day[:icon]
      }
    end
  end
end
