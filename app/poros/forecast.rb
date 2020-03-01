class Forecast
  attr_reader :id

  def initialize(location)
    @id = nil
    @location = location
    @google_service = GoogleService.new(location).get_location[:results][0]
  end

  def full_forecast
    {
      time_zone: 'UTC',
      location: @google_service[:formatted_address],
      currently: current_data,
      today: today_data,
      hourly: hourly_data,
      daily: daily_data
    }
  end

private

  def raw_data
    @raw_data ||= DarkSkyService.new(lat_long).get_forecast
  end

  def hourly_data
    raw_data[:hourly][:data][0..7].map do |hour|
      Hour.info(hour)
    end
  end

  def daily_data
    raw_data[:daily][:data][0..4].map do |day|
      Day.info(day)
    end
  end

  def current_data
    Current.info(raw_data[:currently])
  end

  def today_data
    Today.info(raw_data)
  end

  def lat_long
    location = @google_service[:geometry][:location]
    "#{location[:lat]},#{location[:lng]}"
  end
end
