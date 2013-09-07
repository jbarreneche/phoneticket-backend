require 'test_helper'

class ApiSignupTest < ActionDispatch::IntegrationTest

  test "basic login" do
    post "/api/users/sessions", {
      email: "existing@user.com",
      password: "password"
    }, "HTTP_ACCEPT" => "application/json"

    assert_equal 200, status

    assert_equal json_response["email"], "existing@user.com"
  end

  test "doesnt allow signin for unconfirmed users" do
    post "/api/users/sessions", {
      email: "unconfirmed_user@user.com",
      password: "password"
    }, "HTTP_ACCEPT" => "application/json"

    assert_equal 401, status

    assert_equal json_response["error"], I18n.t("devise.failure.unconfirmed")
  end

  test "doesnt allow signin with invalid email" do
    post "/api/users/sessions", {
      email: "user.email@invalid.com",
      password: "password"
    }, "HTTP_ACCEPT" => "application/json"

    assert_equal 401, status

    assert_equal json_response["error"], I18n.t("devise.failure.invalid")
  end

  test "doesnt allow signin with invalid passwod" do
    user = users("first_user")

    post "/api/users/sessions", {
      email: user.email,
      password: "invalid password"
    }, "HTTP_ACCEPT" => "application/json"

    assert_equal 401, status

    assert_equal json_response["error"], I18n.t("devise.failure.invalid")
  end

  def json_response
    JSON(response.body)
  end
end
