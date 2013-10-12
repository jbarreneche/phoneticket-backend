require 'test_helper'

class APIShowAvailability < ActionDispatch::IntegrationTest
  setup do
    @show = shows(:Show_1)
  end

  test "It marks show status for each body" do
    get "/api/shows/#{@show.id}", {}, "Accept" => "application/json"

    assert_equal 200, status

    assert_equal %w[left middle right], json_response['status'].keys
  end

  test "it returns all seats" do
    get "/api/shows/#{@show.id}", {}, "Accept" => "application/json"

    assert_equal 200, status

    seats = [
      %w[a-1 a-2 a-3 a-4],
      %w[b-1 b-2 b-3 b-4],
      %w[c-1 c-2 c-3 c-4],
      %w[d-1 d-2 d-3 d-4]
    ]

    assert_equal seats, json_response['status']['left']['seats']
  end

  test "it returns void seats" do
    get "/api/shows/#{@show.id}", {}, "Accept" => "application/json"

    assert_equal 200, status

    assert_equal %w[a-1], json_response['status']['left']['void_seats']
  end

  test "it returns reserved seats" do
    get "/api/shows/#{@show.id}", {}, "Accept" => "application/json"

    assert_equal 200, status

    assert_equal %w[b-1], json_response['status']['left']['reserved_seats']
  end

  test "it returns column names" do
    get "/api/shows/#{@show.id}", {}, "Accept" => "application/json"

    assert_equal 200, status

    assert_equal %w[1 2 3 4], json_response['status']['left']['columns']
  end

  test "it returns row names" do
    get "/api/shows/#{@show.id}", {}, "Accept" => "application/json"

    assert_equal 200, status

    assert_equal %w[a b c d], json_response['status']['left']['rows']
  end

  def json_response
    JSON(response.body)
  end
end
