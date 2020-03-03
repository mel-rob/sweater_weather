class Roadtrip
  attr_reader :id, :origin, :destination

  def initialize(origin, destination)
    @id = nil
    @origin = origin
    @destination = destination
  end

  def travel_time
    directions_info[:duration][:text]
  end

  def arrival_forecast
    roadtrip_forecast
  end

private

  def directions_info
    @directions_info ||= GoogleService.new(@origin).get_directions(@destination)[:routes][0][:legs][0]
  end

  def lat_long
    "#{directions_info[:end_location][:lat]},#{directions_info[:end_location][:lng]}"
  end

  def travel_time_secs
    directions_info[:duration][:value]
  end

  def darksky_prediction
    DarkSkyService.new(lat_long).get_arrival_forecast(travel_time_secs)
  end

  def roadtrip_forecast
    RoadtripForecast.new(darksky_prediction)
  end
end
