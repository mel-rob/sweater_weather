require 'rails_helper'

RSpec.describe "I can retrieve a background image for a city", :type => :request do
  it 'can find an image based on the city and return the url', :vcr do

    get '/api/v1/backgrounds?location=denver,co', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    image = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(image[:background_url]).to_not be_falsey
    expect(image[:background_url]).to be_a String
  end
end
