require_relative 'helper'
require 'sqlite3'

class TestEnteringMovies < MovieTest
  def test_01_valid_movie_entry_gets_saved
    `./movie add 'Good Will Hunting' -s "t" -o "t" --ws "t" --wo "t" -r 100 --environment test`
    movie_entry = MovieEntries.all.first
    expected = ["Good Will Hunting", true, true, true, true, "100"]
    actual = [movie_entry.title, movie_entry.seen, movie_entry.own, movie_entry.wishlist_see, movie_entry.wishlist_own, movie_entry.user_rating]
    assert_equal expected, actual
    assert_equal 1, MovieEntries.count
  end

  def test_02_invalid_movie_entry_doesnt_get_saved
    `./movie add -s "t" -o "t" --wo "t" -r 100`
    assert_equal 0, MovieEntries.count
  end

  def test_03_error_message_for_missing_title
    command = "./movie add -s t -o --ws t --wo -r 100"
    expected = "You must provide the movie title you are adding"
    assert_command_output expected, command
  end

  def test_04_missing_seen_defaults_false
    `./movie add 'Good Will Hunting' -o "t" -s --ws "t" --wo "t" -r 100 --environment test`
    movie_entry = MovieEntries.last
    actual = [movie_entry.title, movie_entry.seen, movie_entry.own, movie_entry.wishlist_see, movie_entry.wishlist_own, movie_entry.user_rating]
    expected = ["Good Will Hunting", false, true, true, true, "100"]
    assert_equal expected, actual

    assert_equal 1, MovieEntries.count
  end

  def test_05_missing_own_defaults_false
    `./movie add 'Good Will Hunting' -s "t" -o --wo "t" --ws "t" -r 100 --environment test`
    movie_entry = MovieEntries.last
    actual = [movie_entry.title, movie_entry.seen, movie_entry.own, movie_entry.wishlist_see, movie_entry.wishlist_own, movie_entry.user_rating]
    expected = ["Good Will Hunting", true, false, true, true, "100"]
    assert_equal expected, actual

    assert_equal 1, MovieEntries.count
  end

  def test_06_missing_wishlist_see_defaults_false
    `./movie add 'Good Will Hunting' -s "t" -o "t" --ws --wo "t" -r 100 --environment test`
    movie_entry = MovieEntries.last
    actual = [movie_entry.title, movie_entry.seen, movie_entry.own, movie_entry.wishlist_see, movie_entry.wishlist_own, movie_entry.user_rating]
    expected = ["Good Will Hunting", true, true, false, true, "100"]
    assert_equal expected, actual

    assert_equal 1, MovieEntries.count
  end

  def test_07_missing_wishlist_own_defaults_false
    `./movie add 'Good Will Hunting' -s "t" -o "t" --ws "t" --wo -r 100 --environment test`
    movie_entry = MovieEntries.last
    actual = [movie_entry.title, movie_entry.seen, movie_entry.own, movie_entry.wishlist_see, movie_entry.wishlist_own, movie_entry.user_rating]
    expected = ["Good Will Hunting", true, true, true, false, "100"]
    assert_equal expected, actual

    assert_equal 1, MovieEntries.count
  end

  def test_08_rating_defaults_to_none
    `./movie add 'Good Will Hunting' -s "t" -o "t" --ws "t" --wo "t" --environment test`
    movie_entry = MovieEntries.last
    actual = [movie_entry.title, movie_entry.seen, movie_entry.own, movie_entry.wishlist_see, movie_entry.wishlist_own, movie_entry.user_rating]
    expected = ["Good Will Hunting", true, true, true, true, "none"]
    assert_equal expected, actual

    assert_equal 1, MovieEntries.count
  end

  def test_09_valid_movie_information_gets_printed
    Movie.find_or_create_by(title: "American Hustle", year: "2013", rated: "R", runtime: "138 min", genre: "Crime, Drama", tomato_meter: "92", tomato_image: "certified", tomato_user_meter: "81", released: "20 Dec 2013", dvd: "N/A", production: "Sony Pictures", box_office: "$87.9M")
    command = "./movie add 'American Hustle' -s t -o --ws --wo t -r 80"
    expected = "A movie named American Hustle, with seen? true, own? false, wishlist see false, wishlist own true, user rating 80, released in 2013, rated R, runtime 138 min, genre Crime, Drama, tomato meter 92, released by Sony Pictures with a box office of $87.9M was created"
    assert_command_output expected, command
  end

  def test_error_message_for_missing_seen?
    command = "./movie add 'Good Will Hunting' -o t --ws --wo  -r 100"
    expected = "You must provide the seen? of the movie you are adding"
    assert_command_output expected, command
  end

  def test_error_message_for_missing_own?
    command = "./movie add 'Good Will Hunting' -s t --ws --wo -r 100"
    expected = "You must provide the own? of the movie you are adding"
    assert_command_output expected, command
  end

  def test_error_message_for_missing_wishlist_see?
    command = "./movie add 'Good Will Hunting' -s t -o t --wo -r 100"
    expected = "You must provide the wishlist see of the movie you are adding"
    assert_command_output expected, command
  end

  def test_error_message_for_missing_wishlist_own?
    command = "./movie add 'Good Will Hunting' -s t -o t --ws -r 100"
    expected = "You must provide the wishlist own of the movie you are adding"
    assert_command_output expected, command
  end

  def test_error_message_for_missing_rating
    command = "./movie add 'Good Will Hunting' -s t -o t --ws --wo -r"
    expected = "You must provide the user rating of the movie you are adding"
    assert_command_output expected, command
  end
end