class YelpService

  def initialize(destination, food_type)
    @destination = destination
    @food_type = food_type
  end

  def get_restaurant(seconds)
    get_arrival_json((Time.now + seconds).to_i)
  end

private

  def conn
    Faraday.new("https://api.yelp.com/v3/businesses/search") do |faraday|
      faraday.headers[:Authorization] = ENV['YELP_API_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_arrival_json(arrival_time)
    response = conn.get do |request|
      request.params['location'] = @destination
      request.params['term'] = @food_type
      request.params['open_at'] = arrival_time
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
