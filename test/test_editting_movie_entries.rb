require_relative 'helper'
require 'sqlite3'

class TestEditingMovies < MovieTest
  def test_updating_a_record_that_exists
    movie_entry = MovieEntries.new(title: "Gravity", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    movie_entry.save
    id =  movie_entry.id
    command = "./movie edit --id #{id} -t 'American Hustle' -s t -o t --ws f --wo f -r 85 --environment test"
    expected = "Movie entry #{id} is now named American Hustle, with seen t, own t, wishlist see f, wishlist own f, user rating 85"
    assert_command_output expected, command
  end

  def test_attempting_to_update_a_nonexistant_record
    command = "./movie edit --id 123456789 -t 'American Hustle' -s t -o t --ws f --wo f -r 85"
    expected = "Movie entry 123456789 couldn't be found"
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_no_changes
    movie_entry = MovieEntries.new(title: "Gravity", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    movie_entry.save
    id =  movie_entry.id
    command = "./movie edit --id #{id} -t Gravity -s t -o f --ws f --wo t -r 75"
    expected = "Movie entry #{id} is now named Gravity, with seen t, own f, wishlist see f, wishlist own t, user rating 75"
  end

  def test_attempting_to_update_with_bad_data
    skip
    movie_entry = MovieEntries.new(title: "Gravity", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    movie_entry.save
    id =  movie_entry.id
    command = "./movie edit --id #{id} -t Gravity -s t -o f --ws f --wo t -r million"
    expected = "Movie entry #{id} can't be updated. Rating must be a number from 1 to 100"
    assert_command_output expected, command
  end

  def test_attempting_to_update_partial_data
    skip
    movie_entry = MovieEntries.new(title: "Gravity", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    movie_entry.save
    id =  movie_entry.id
    command = "./movie edit --id#{id} --title Gravity!"
    expected = "Movie entry #{id} is now named Gravity, with seen t, own f, wishlist see f, wishlist own t, user rating 75"
    assert_command_output expected, command
  end
end
