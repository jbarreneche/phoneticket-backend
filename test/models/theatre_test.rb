require 'test_helper'

class TheatreTest < ActiveSupport::TestCase
  test "Theatre as string" do
    theatre = Theatre.new(name: "Cine 1")
    assert_equal "Cine 1", theatre.to_s
  end
end
