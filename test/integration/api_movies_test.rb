require 'test_helper'

class APIMoviesTest < ActionDispatch::IntegrationTest
  setup do
    @matrix = movies(:Movie_1)
  end

  test "available movies" do
    get "/api/movies", {}, "Accept" => "application/json"

    assert_equal 200, status

    # Matrix is currently the only one with an available show
    assert_equal 1, json_response.count
  end

  test "Movie information" do
    get "/api/movies/#{@matrix.id}", {}, "Accept" => "application/json"

    assert_equal 200, status

    # Matrix is currently displayed only in Room_1
    assert_equal 1, json_response["theatres"].count
  end

  def json_response
    JSON(response.body)
  end
end
