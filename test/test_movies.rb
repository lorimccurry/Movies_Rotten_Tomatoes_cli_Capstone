require_relative 'helper'
require_relative '../models/movie'

class TestMovies < MovieTest
  def test_movies_are_created
    foos_before = database.execute("select count(id) from movies")[0][0]
    Movie.create(title: "Foo")
    foos_after = database.execute("select count(id) from movies")[0][0]
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    movie = Movie.create(title: "Foo")
    refute_nil movie.id, "Movie id shouldn't be nil"
  end

  def test_all_returns_all_movies_in_alphabetical_order
    Movie.create(title: "foo")
    Movie.create(title: "bar")
    expected = ["bar", "foo"]
    actual = Movie.all.map{ |movie| movie.title}
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_categories
    results = Movie.all
    assert_equal [], results
  end

end
