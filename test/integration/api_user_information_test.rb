require 'test_helper'

class ApiUserInformationTest < ActionDispatch::IntegrationTest

  test "retrieve basic user information" do
    get "/api/users/me", {
      email: "existing@user.com"
    }, "HTTP_ACCEPT" => "application/json"


    assert_equal 200, status

    assert_equal json_response["email"], "existing@user.com"
  end

  test "update basic information" do
    put "/api/users/me", {
      email: "existing@user.com",
      document: "44444"
    }, "HTTP_ACCEPT" => "application/json"


    assert_equal 200, status

    assert_equal "44444", users(:first_user).document
  end

  def json_response
    JSON(response.body)
  end
end
