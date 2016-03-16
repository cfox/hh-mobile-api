require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'uuid'

require_relative 'environments'
require_relative 'model'

get '/api' do
  redirect '/api/index.html'
end

before '/v1/*' do
  # TODO: authenticate the client app here
  halt 403 if params['api_key'].nil? || params['api_key'].empty?
end

helpers do
  def require_params!(*names)
    names.each do |name| 
      halt 422 if params[name].nil? || params[name].empty?
    end
  end
end

# GET /ping
get '/v1/ping' do
  {"ping" => "pong"}.to_json
end

# POST /users/facebookLogin
post '/v1/users/facebookLogin' do
  require_params!('screen_name', 'facebook_id')

  existing_user = User.find_by(facebook_access_token: params['facebook_id'])

  if existing_user

    return [200, {:accessKey => existing_user.access_token}.to_json]

  else

    new_access_token = UUID.new.generate
    user = User.create(access_token: new_access_token,
                       facebook_access_token: params['facebook_id'],
                       screen_name: params['screen_name'])
    return [200, {:accessKey => user.access_token}.to_json]

  end
end

# POST /users/attributes
# TODO: Implement me!
post '/v1/users/attributes' do
  200
end

# GET /places/ratings
# TODO: Implement me!
get '/v1/places/ratings' do
  sample = <<-SAMPLE
  [
    {
      "placeId": "41cb61df-647c-4572-8f93-24df4cf63a0b",
      "rating": 0
    },
    {
      "placeId": "5759a3a9-a3d9-4fd9-ab39-e6d979c78e0e",
      "rating": 5
    }
  ]
  SAMPLE
  return [200, sample]
end

# GET /places/recommendations
# TODO: Implement me!
get '/v1/places/recommendations' do
  sample = <<-SAMPLE
[
  {
    "placeId": "41cb61df-647c-4572-8f93-24df4cf63a0b",
    "yeaCount": 5,
    "nayCount": 2,
    "mehCount": 1,
    "feedbackCount": 4,
    "topFbFriends": [
      "68c8357b-9071-42ed-939c-07c6362f6c2c",
      "2ce1fa28-7d7c-4356-9535-f5e5a8b28241"
    ]
  },
  {
    "placeId": "5759a3a9-a3d9-4fd9-ab39-e6d979c78e0e",
    "yeaCount": 3,
    "nayCount": 0,
    "mehCount": 1,
    "feedbackCount": 1,
    "topFbFriends": [
      "6b5c1bb9-c937-44a9-8d75-baea2778b316"
    ]
  }
]
  SAMPLE
  return [200, sample]
end

# POST /users/friends
# TODO: Implement me!
post '/v1/users/friends' do
  200
end

# GET /users/feedback
# TODO: Implement me!
get '/v1/users/feedback' do
  sample = <<-SAMPLE
{
  "placeId": "41cb61df-647c-4572-8f93-24df4cf63a0b",
  "rating": 3,
  "categorizedRatings": [
    {
      "category": "service",
      "rating": 2
    },
    {
      "category": "cleanliness",
      "rating": 4
    }
  ],
  "feedback": [
    {
      "screenName": "FoodCritic17",
      "facebookId": "68c8357b-9071-42ed-939c-07c6362f6c2c",
      "recommendation": "yea",
      "friendFeedback": "Was pretty ok I guess.  I liked the eggrolls."
    },
    {
      "screenName": "EasyRider99",
      "facebookId": "2ce1fa28-7d7c-4356-9535-f5e5a8b28241",
      "recommendation": "meh",
      "friendFeedback": "Bland as heck dude!  They need to kick it up."
    }
  ]
}
  SAMPLE
  return [200, sample]
end

# POST /users/feedback
# TODO: Implement me!
post '/v1/users/feedback' do
  200
end

# POST /users/follows
# TODO: Implement me!
post '/v1/users/follows' do
  200
end
