require 'rails_helper'

describe 'I can create a road trip', :type => :request do

  it 'can take in road trip info and return travel time and arrival forecast', :vcr do
    WebMock.enable_net_connect!
    VCR.eject_cassette
    VCR.turn_off!(ignore_cassettes: true)
    user = User.create({
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    })
    post '/api/v1/road_trip', params: {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        api_key: user.api_key
      }.to_json, headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

    expect(response).to be_successful
    road_trip = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(road_trip[:origin]).to eq('Denver,CO')
    expect(road_trip[:destination]).to eq('Pueblo,CO')
    expect(road_trip[:travel_time]).to eq('1 hour 48 mins')
    expect(road_trip[:forecast].keys).to eq([:summary, :temp])
    expect(road_trip[:forecast][:temp]).to be_a Float
    expect(road_trip[:forecast][:summary]).to be_a String
  end

  it 'will not take in road trip info without a valid API key' do
    post '/api/v1/road_trip', params: {
        origin: "Denver,CO",
        destination: "Pueblo,CO"
      }.to_json, headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

    expect(response).to_not be_successful
    road_trip = JSON.parse(response.body, symbolize_names: true)
    expect(road_trip[:failed]).to eq('Unauthorized')
  end
end
