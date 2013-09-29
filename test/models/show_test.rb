require 'test_helper'

class ShowTest < ActiveSupport::TestCase
  test "it's name is the movie title with the room label" do
    room = Room.new(name: "Room")
    movie = Movie.new(title: "Some movie")
    show = Show.new(movie: movie, room: room)
    assert show.name.include?(movie.title)
    assert show.name.include?(room.to_label)
  end
end
