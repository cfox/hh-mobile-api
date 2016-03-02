require 'sinatra'
require 'sinatra/activerecord'
require 'json'

require_relative 'environments'
require_relative 'model'

get '/ping' do
  "pong"
end

