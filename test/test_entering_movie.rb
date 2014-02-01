require_relative 'helper'
require 'sqlite3'

class TestEnteringMovies < MovieTest
  def test_01_valid_movie_gets_saved
    `./movie add 'Good Will Hunting' -s -o --ws --wo -r 100 --environment test`
    database.results_as_hash = false
    results = database.execute("select title, seen, own, wishlist_see, wishlist_own, user_rating from movie_entries")
    expected = ["Good Will Hunting", "true", "true", "true", "true", "100"]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from movie_entries")
    assert_equal 1, result[0][0]
  end

  def test_02_invalid_movie_doesnt_get_saved
    `./movie add -s -o --ws --wo -r 100`
    result = database.execute("select count(id) from movie_entries")
    assert_equal 0, result[0][0]
  end

  def test_03_error_message_for_missing_title
    command = "./movie add"
    expected = "You must provide the movie title you are adding"
    assert_command_output expected, command
  end

  def test_04_missing_seen_defaults_false
    `./movie add 'Good Will Hunting' -o --ws --wo -r 100 --environment test`
    database.results_as_hash = false
    results = database.execute("select title, seen, own, wishlist_see, wishlist_own, user_rating from movie_entries")
    expected = ["Good Will Hunting", "false", "true", "true", "true", "100"]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from movie_entries")
    assert_equal 1, result[0][0]
  end

  def test_05_missing_own_defaults_false
    `./movie add 'Good Will Hunting' -s --wo --ws -r 100 --environment test`
    database.results_as_hash = false
    results = database.execute("select title, seen, own, wishlist_see, wishlist_own, user_rating from movie_entries")
    expected = ["Good Will Hunting", "true", "false", "true", "true", "100"]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from movie_entries")
    assert_equal 1, result[0][0]
  end

  def test_06_missing_wishlist_see_defaults_false
    `./movie add 'Good Will Hunting' -s -o --wo -r 100 --environment test`
    database.results_as_hash = false
    results = database.execute("select title, seen, own, wishlist_see, wishlist_own, user_rating from movie_entries")
    expected = ["Good Will Hunting", "true", "true", "false", "true", "100"]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from movie_entries")
    assert_equal 1, result[0][0]
  end

  def test_07_missing_wishlist_own_defaults_false
    `./movie add 'Good Will Hunting' -s -o --ws -r 100 --environment test`
    database.results_as_hash = false
    results = database.execute("select title, seen, own, wishlist_see, wishlist_own, user_rating from movie_entries")
    expected = ["Good Will Hunting", "true", "true", "true", "false", "100"]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from movie_entries")
    assert_equal 1, result[0][0]
  end

  def test_08_rating_defaults_to_none
    `./movie add 'Good Will Hunting' -s -o --ws --wo --environment test`
    database.results_as_hash = false
    results = database.execute("select title, seen, own, wishlist_see, wishlist_own, user_rating from movie_entries")
    expected = ["Good Will Hunting", "true", "true", "true", "true", "none"]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from movie_entries")
    assert_equal 1, result[0][0]
  end

  def test_09_valid_movie_information_gets_printed
    command = "./movie add 'American Hustle' -s --wo -r 80"
    expected = "A movie named American Hustle, with seen? true, own? false, wishlist see false, wishlist own true, user rating 80 was created"
    assert_command_output expected, command
  end
end