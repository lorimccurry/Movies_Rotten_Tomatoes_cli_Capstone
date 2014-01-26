require_relative 'helper'
require_relative '../models/movie_entry'

class TestMovieEntry < MovieTest
  def test_to_s_prints_details
    movie_entry = MovieEntry.new(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", rating: "75")
    expected = "Foo: seen t, own f, wishlist see f, wishlist own t, rating: 75"
    assert_equal expected, movie_entry.to_s
  end
end