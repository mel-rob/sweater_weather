class DarkSkyService

  def initialize(lat_long)
    @lat_long = lat_long
  end

  def get_forecast
    get_json
  end

  def get_arrival_forecast(seconds)
    prediction_json((Time.now + seconds).to_i)
  end
  
private

  def conn
    Faraday.new("https://api.darksky.net/forecast/#{ENV['DARK_SKY_KEY']}") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json
    response = conn.get(@lat_long)
    JSON.parse(response.body, symbolize_names: true)
  end

  def prediction_json(seconds)
    response = conn.get("#{@lat_long},#{seconds}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
