class FiveDayForecastSerializer
  include JSONAPI::Serializer

  set_id { nil }

  attribute :data do |object|
    object[:data].map do |day|
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
