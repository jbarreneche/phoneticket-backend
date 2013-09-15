require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  test "#disable! disables user for authentication" do
    user = users("first_user")
    assert user.disable!
    refute user.active_for_authentication?
  end

  test "#enable! reenables user for authentication" do
    user = users("first_user")
    assert user.disable! && user.enable!
    assert user.active_for_authentication?
  end
end
