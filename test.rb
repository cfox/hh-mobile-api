ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require_relative 'mobile-api.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Mobile API" do

  it "should pong a ping" do
    get '/ping'
    "pong".must_equal last_response.body
  end

end
