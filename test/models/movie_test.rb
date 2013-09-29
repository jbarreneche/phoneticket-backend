require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  test "setting the cast as a text separated with \n" do
    movie = Movie.new
    refute movie.valid?
    refute movie.errors[:cast_raw].empty?

    movie.cast_raw = <<-CAST
      Actor one
    CAST
    movie.valid?

    assert movie.errors[:cast_raw].empty?
    assert_equal ["Actor One"], movie.cast
    assert_equal "Actor One", movie.cast_raw
  end
end
