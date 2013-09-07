require 'test_helper'

class ApiSignupTest < ActionDispatch::IntegrationTest

  test "basic signup" do
    post "/api/users", {
      email: "someone@signinup.com",
      password: "123456"
    }, "HTTP_ACCEPT" => "application/json"

    assert_equal 200, status

    assert_equal json_response["email"], "someone@signinup.com"
  end

  def json_response
    JSON(response.body)
  end
end
