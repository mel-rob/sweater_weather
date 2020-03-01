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
    expect(forecast[:currently].keys).to eq([:time, :summary, :feels_like, :humidity, :visibility, :uv_index, :temp, :icon])
    expect(forecast[:today].keys).to eq([:today_summary, :tonight_summary, :high, :low, :date])
    expect(forecast[:hourly].length).to eq(8)
    expect(forecast[:hourly][0].keys).to eq([:time, :temp, :icon])
    expect(forecast[:daily].length).to eq(5)
    expect(forecast[:daily][0].keys).to eq([:summary, :precipitation_prob, :precipitation_type, :high, :low, :day, :icon])
  end
end
