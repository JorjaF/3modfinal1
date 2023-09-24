class ForecastSerializer 
  include JSONAPI::Serializer

  set_id do |object|
    nil
  end

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

  attribute :current do |object|
    {
      last_updated: object[:current][:last_updated],
      temp_f: object[:current][:temp_f],
      
      condition: {
        text: object[:current][:condition][:text],
        icon: object[:current][:condition][:icon],      
      },
      humidity: object[:current][:humidity],
      feelslike_f: object[:current][:feelslike_f],
      vis_miles: object[:current][:vis_miles],
      uvi: object[:current][:uv],
      gust_mph: object[:current][:gust_mph],
      gust_kph: object[:current][:gust_kph]
    }
  end
end
