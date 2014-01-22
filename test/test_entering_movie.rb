require_relative 'helper'
require 'sqlite3'

class TestEnteringMovies < MovieTest
  def test_01_valid_movie_gets_saved
    `./movie add 'Good Will Hunting' -s t -o t --ws f --wo f -r 100`
    results = database.execute("select title, seen, own, wishlist_see, wishlist_own, user_rating from cinephile_movies_test")
    expected = ["Good Will Hunting", "t", "t", "f", "f", 100]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from cinephile_movies_test")
    assert_equal 1, result[0][0]
  end

  def test_02_invalid_movie_doesnt_get_saved
    skip "needs implementation"
    assert false, "Missing test implementation"
  end

  def test_03_error_message_for_missing_title
    command = "./movie add"
    expected = "You must provide the movie title you are adding\nYou must provide the seen? and own? and wishlist see and wishlist own and user rating of the movie you are adding"
    assert_command_output expected, command
  end

  def test_04_error_message_for_missing_seen?
    command = "./movie add 'Good Will Hunting' -o t --ws f --wo f -r 100"
    expected = "You must provide the seen? of the movie you are adding"
    assert_command_output expected, command
  end

  def test_05_error_message_for_missing_own?
    command = "./movie add 'Good Will Hunting' -s t --ws f --wo f -r 100"
    expected = "You must provide the own? of the movie you are adding"
    assert_command_output expected, command
  end

  def test_06_error_message_for_missing_wishlist_see?
    command = "./movie add 'Good Will Hunting' -s t -o t --wo f -r 100"
    expected = "You must provide the wishlist see of the movie you are adding"
    assert_command_output expected, command
  end

  def test_07_error_message_for_missing_wishlist_own?
    command = "./movie add 'Good Will Hunting' -s t -o t --ws f -r 100"
    expected = "You must provide the wishlist own of the movie you are adding"
    assert_command_output expected, command
  end

  def test_08_error_message_for_missing_rating
    command = "./movie add 'Good Will Hunting' -s t -o t --ws f --wo f"
    expected = "You must provide the user rating of the movie you are adding"
    assert_command_output expected, command
  end

  def test_09_valid_movie_information_gets_printed
    command = "./movie add 'American Hustle' -s t -o f --ws f --wo t -r 80"
    expected = "A movie named American Hustle, with seen? t, own? f, wishlist see f, wishlist own t, rating 80"
    assert_command_output expected, command
  end
end