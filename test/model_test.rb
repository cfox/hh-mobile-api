ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'

require_relative '../environments'
require_relative '../model'

class UserTest < ActiveSupport::TestCase

  test "sanity" do
    User
  end

  test "new User isn't nil" do
    user = User.create

    refute_nil user

    assert_instance_of User, user

    refute_nil user.id
    refute_empty user.id
  end

end
