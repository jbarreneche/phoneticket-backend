require 'test_helper'

class ApiTheatresTest < ActionDispatch::IntegrationTest
  setup do
    @cine_1 = theatres(:Theatre_1)
  end

  test "available movies" do
    get "/api/theatres", {}, "Accept" => "application/json"

    assert_equal 200, status

    assert_equal 3, json_response.count
  end

  test "Movie information" do
    get "/api/theatres/#{@cine_1.id}", {}, "Accept" => "application/json"

    assert_equal 200, status

    # Matrix is currently the only displayed movie
    assert_equal 1, json_response["movies"].count
  end

  def json_response
    JSON(response.body)
  end
end
