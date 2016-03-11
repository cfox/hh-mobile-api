ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'

require_relative '../api'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Mobile API" do

  describe "get /ping" do
    it "should 403 on bad api_key" do
      get '/v1/ping'
      last_response.status.must_equal(403)

      get '/v1/ping', {:api_key => 'abc123'}
      last_response.status.wont_equal(403)
    end

    it "should pong a ping" do
      get '/v1/ping', {:api_key => 'abc123'}
      expected = {"ping" => "pong"}.to_json
      last_response.body.must_equal(expected)
    end
  end

  describe "post /users/facebookLogin" do

    it "should 403 on bad api_key" do
      post '/v1/users/facebookLogin'
      last_response.status.must_equal(403)
    end

    it "should 422 on missing parameters" do
      post '/v1/users/facebookLogin', {:api_key => 'abc123'}
      last_response.status.must_equal(422)

      post '/v1/users/facebookLogin', {:api_key => 'abc123', :screen_name => 'User123'}
      last_response.status.must_equal(422)

      post '/v1/users/facebookLogin', {:api_key => 'abc123', :facebook_id => 'abc'}
      last_response.status.must_equal(422)

      post '/v1/users/facebookLogin', {:api_key => 'abc123', :screen_name => 'User123', :facebook_id => ''}
      last_response.status.must_equal(422)

      post '/v1/users/facebookLogin', {:api_key => 'abc123', :screen_name => '', :facebook_id => 'abc'}
      last_response.status.must_equal(422)

      post '/v1/users/facebookLogin', {:api_key => 'abc123', :screen_name => 'User123', :facebook_id => 'abc'}
      last_response.status.wont_equal(422)
    end

    it "should return an access_key" do
      facebook_id = UUID.new.generate

      # login new user
      post '/v1/users/facebookLogin', {:api_key => 'abc123',
                                       :screen_name => 'User123',
                                       :facebook_id => facebook_id}

      access_key = last_response.body.to_json["accessKey"]
      access_key.wont_be_empty

      # now re-login existing user
      post '/v1/users/facebookLogin', {:api_key => 'abc123',
                                       :screen_name => 'User123',
                                       :facebook_id => facebook_id}

      access_key = last_response.body.to_json["accessKey"]
      access_key.wont_be_empty
    end
  end
end
