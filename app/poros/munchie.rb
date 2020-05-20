class Munchie
  attr_reader :id

  def initialize(origin, destination, food_type)
    @id = nil
    @origin = origin
    @destination = destination
    @food_type = food_type
  end

  def end_location
    google_direction_data[:end_address]
  end

  def travel_time
    google_direction_data[:duration][:text]
  end

  def forecast
    darksky_forecast_data[:currently][:summary]
  end

  def restaurant
    {
      name: yelp_restaurant_data[:name],
      address: yelp_restaurant_data[:location][:display_address].join(', ')
    }
  end

private

  def google_direction_data
    @google_direction_data ||= GoogleService.new(@origin, @destination).get_directions[:routes][0][:legs][0]
  end

  def darksky_forecast_data
    @darksky_forecast_data ||= DarkSkyService.new(lat_long).get_forecast_on_arrival(travel_time_secs)
  end

  def lat_long
    end_location = google_direction_data[:end_location]
    "#{end_location[:lat]},#{end_location[:lng]}"
  end

  def travel_time_secs
    google_direction_data[:duration][:value]
  end

  def yelp_restaurant_data
    @yelp_restaurant_data ||= YelpService.new(@destination, @food_type).get_restaurant(travel_time_secs)[:businesses][0]
  end
end
