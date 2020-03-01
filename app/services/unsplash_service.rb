class UnsplashService

  def initialize(location)
    @location = location.split(',')[0]
  end

  def get_background
    background_json
  end

private

  def conn
    Faraday.new('https://api.unsplash.com/search/photos') do |faraday|
      faraday.params[:query] = @location
      faraday.params[:client_id] = ENV['UNSPLASH_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end

  def background_json
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end
end
