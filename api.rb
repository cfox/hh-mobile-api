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

get '/v1/ping' do
  {"ping" => "pong"}.to_json
end

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
