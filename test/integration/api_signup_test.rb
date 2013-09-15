require 'test_helper'

class ApiSignupTest < ActionDispatch::IntegrationTest

  test "basic signup" do
    post "/api/users", {
      email: "someone@signinup.com",
      password: "123456",
      document: "123"
    }, "HTTP_ACCEPT" => "application/json"

    assert_equal 200, status

    assert_equal json_response["email"], "someone@signinup.com"
  end

  test "doesnt allow duplicate emails" do
    user = users("first_user")

    post "/api/users", {
      email: user.email,
      password: "123456",
      document: "123"
    }, "HTTP_ACCEPT" => "application/json"

    assert_equal 422, status

    assert json_response["errors"].has_key?("email")
  end

  def json_response
    JSON(response.body)
  end
end
