require 'sinatra/activerecord/rake'

require_relative 'api'

def include_tests
  require_relative 'api_test'
  require_relative 'model_test'
end

task(:test) {
  include_tests
}

task(:default) {
  include_tests
}
