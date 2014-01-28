require_relative 'helper'
require_relative '../models/movie_entries'

class TestMovieEntries < MovieTest
  def test_to_s_prints_details
    movie_entry = MovieEntries.new(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    expected = "Foo: seen t, own f, wishlist see f, wishlist own t, user rating: 75, id: #{movie_entry.id}"
    assert_equal expected, movie_entry.to_s
  end

  def test_saved_movie_entries_are_saved
    movie_entry = MovieEntries.new(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    foos_before = database.execute("select count(id) from movie_entries")[0][0]
    movie_entry.save
    foos_after = database.execute("select count(id) from movie_entries")[0][0]
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    movie_entry = MovieEntries.create(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    refute_nil movie_entry.id, "Movie entry shouldn't be nil"
  end

  def test_all_movie_entries_in_alphabetical_order
    MovieEntries.create(title: "foo", seen: "t", own: "f", wishlist_see: "t", wishlist_own: "t", user_rating: "42")
    MovieEntries.create(title: "bar", seen: "f", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "67")
    results = MovieEntries.all
    expected = ["bar", "foo"]
    actual = results.map{|movie_entry| movie_entry.title}
    assert_equal expected, actual
  end

  def test_all_movies_empty_array_if_no_movies
    results = MovieEntries.all
    assert_equal [], results
  end
end