require 'rails_helper'

RSpec.describe 'I can create a user', :type => :request do
  it 'can take in registration info and return an API key' do

    post '/api/v1/users', params: {
    email: "whatever@example.com",
    password: "password",
    password_confirmation: "password"
  }.to_json, headers: {
    'Content-Type' => 'application/json',
    'Accept' => 'application/json'
  }

  expect(response).to be_successful
  
