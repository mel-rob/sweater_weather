require 'rails_helper'

RSpec.describe 'I can receive a forecast for a city', :type => :request do
  it 'returns all necessary info based on FE requirements', :vcr do

    get '/api/v1/forecast?location=denver,co', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:full_forecast]

    expect(forecast[:location]).to be_a String
    expect(forecast[:currently].keys).to eq([:summary, :feels_like, :humidity, :visibility, :uv_index, :temp, :icon, :time])
    expect(forecast[:today].keys).to eq([:tonight_summary, :high, :low, :date, :today_summary])
    expect(forecast[:hourly].length).to eq(8)
    expect(forecast[:hourly][0].keys).to eq([:temp, :icon, :time])
    expect(forecast[:daily].length).to eq(5)
    expect(forecast[:daily][0].keys).to eq([:precipitation_prob, :precipitation_type, :high, :low, :day, :icon, :summary])
  end
end
