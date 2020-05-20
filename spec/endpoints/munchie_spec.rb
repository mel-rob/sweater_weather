require 'rails_helper'

RSpec.describe 'I can receive a munchie for a trip', :type => :request do
  it 'returns all necessary information based on spec', :vcr do

    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    munchie = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(munchie[:end_location]).to be_a String
    expect(munchie[:travel_time]).to be_a String
    expect(munchie[:forecast]).to be_a String
    expect(munchie[:restaurant].length).to eq(2)
    expect(munchie[:restaurant].keys).to eq([:name, :address])
  end
end
