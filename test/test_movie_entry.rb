require_relative 'helper'
require_relative '../models/movie_entry'

class TestMovieEntry < MovieTest
  def test_to_s_prints_details
    movie_entry = MovieEntry.new(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    expected = "Foo: seen t, own f, wishlist see f, wishlist own t, user rating: 75"
    assert_equal expected, movie_entry.to_s
  end

  def test_all_movie_entries_in_alphabetical_order
    database.execute("insert into cinephile_movies_test(title, seen, own, wishlist_see, wishlist_own, user_rating) values('foo', 't', 'f', 't', 't', 42)")
    database.execute("insert into cinephile_movies_test(title, seen, own, wishlist_see, wishlist_own, user_rating) values('bar', 'f', 'f', 'f', 't', 67)")
    results = MovieEntry.all
    expected = ["bar", "foo"]
    actual = results.map{|movie_entry| movie_entry.title}
    assert_equal expected, actual
  end

  def test_all_movies_empty_array_if_no_movies
    results = MovieEntry.all
    assert_equal [], results
  end
end