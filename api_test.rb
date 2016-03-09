ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'

require_relative 'api'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Mobile API" do

  it "should pong a ping" do
    get '/v1/ping'
    expected = {"ping" => "pong"}.to_json
    expected.must_equal last_response.body
  end

end
