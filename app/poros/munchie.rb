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


private

  def google_direction_data
    @google_direction_data ||= GoogleService.new(@origin, @destination).get_directions[:routes][0][:legs][0]
  end
end
