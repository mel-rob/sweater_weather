class Background
  attr_reader :id

  def initialize(location)
    @id = nil
    @location = location
  end

  def background_url
    images = UnsplashService.new(@location).get_background[:results]
    images[0][:urls][:full]
  end

end
