class Roadtrip

  def initialize(origin, destination)
    @id = nil
    @origin = origin
    @destination = destination
  end

  def travel_time
  end

  def arrival_forecast
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
    DarkskyService.new(lat_long).get_arrival_forecast(travel_time_secs)
  end


end
