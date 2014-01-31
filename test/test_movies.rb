require_relative 'helper'
require_relative '../models/movie'

class TestMovies < MovieTest
  def test_movies_are_created_if_needed
    foos_before = database.execute("select count(id) from movies")[0][0]
    Movie.find_or_create("Up")
    foos_after = database.execute("select count(id) from movies")[0][0]
    assert_equal foos_before + 1, foos_after
  end

  def test_movies_are_not_created_if_they_already_exist
    Movie.find_or_create("Gravity")
    foos_before = database.execute("select count(id) from movies")[0][0]
    Movie.find_or_create("Gravity")
    foos_after = database.execute("select count(id) from movies")[0][0]
    assert_equal foos_before, foos_after
  end

  def test_existing_movie_is_returned_by_find_or_create
    movie1 = Movie.find_or_create("Up")
    movie2 = Movie.find_or_create("Up")
    assert_equal movie1.id, movie2.id, "Movie ids should be identical"
  end

  def test_save_creates_an_id
    movie = Movie.find_or_create("Up")
    refute_nil movie.id, "Movie id shouldn't be nil"
  end

  def test_all_returns_all_movies_in_alphabetical_order
    Movie.find_or_create("Gravity")
    Movie.find_or_create("Up")
    expected = ["Gravity", "Up"]
    actual = Movie.all.map{ |movie| movie.title}
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_categories
    results = Movie.all
    assert_equal [], results
  end
end
