class GoogleService

  def initialize(origin)
    @origin = origin
  end

  def get_location
    location_data
  end

  def get_directions(destination)
    direction_data(destination)
  end

private

  def conn(type)
    Faraday.new("https://maps.googleapis.com/maps/api/#{type}/json") do |faraday|
      faraday.params['key'] = ENV['GOOGLE_API_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end

  def location_data
    response = conn.get do |request|
      request.params['address'] = @location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def direction_data(destination)
    response = conn.get do |request|
      request.params['origin'] = @origin
      request.params['destination'] = destination
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
