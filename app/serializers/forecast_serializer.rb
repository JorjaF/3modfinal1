class ForecastSerializer 
  include JSONAPI::Serializer
  
  set_id do |object|
    nil
  end
  
  attribute :current do |object|
    {
      last_updated: object[:current][:last_updated],
      temperature: object[:current][:temp_f],
      feels_like: object[:current][:feelslike_f],
      humidity: object[:current][:humidity],
      uvi: object[:current][:uv],
      visibility: object[:current][:vis_miles],
      condition: object[:current][:condition][:text],
      icon: object[:current][:condition][:icon]
    }
  end
  attribute :location do |object| 
    {
      name: object[:location][:name],
      region: object[:location][:region],
      # country: object[:location][:country],
      # lat: object[:location][:lat],
      # lon: object[:location][:lon],
      # tz_id: object[:location][:tz_id],
      # localtime: object[:location][:localtime]
    }
  end
end
