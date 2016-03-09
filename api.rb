require 'sinatra'
require 'sinatra/activerecord'
require 'json'

require_relative 'environments'
require_relative 'model'

get '/api' do
  redirect '/api/index.html'
end

get '/v1/ping' do
  {"ping" => "pong"}.to_json
end

