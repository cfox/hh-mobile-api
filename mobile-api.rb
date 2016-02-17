require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'json'

class User < ActiveRecord::Base
end

get '/ping' do
  "pong"
end

