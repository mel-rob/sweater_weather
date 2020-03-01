class GoogleService

  def initialize(location)
    @location = location
  end

  def get_location
    location_data
  end

private

  def conn
    Faraday.new('https://maps.googleapis.com/maps/api/geocode/json') do |faraday|
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
end
