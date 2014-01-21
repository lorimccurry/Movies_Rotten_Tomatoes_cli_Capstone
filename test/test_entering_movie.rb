require 'minitest/autorun'
require_relative 'helper'

class TestEnteringMovie < MiniTest::Unit::TestCase
 def test_01_valid_movie_gets_saved
  command = "./movie add"
  expected = 'You must provide the movie title you are adding'
  assert_command_output expected, command
 end

 def test_02_invalid_movie_doesnt_get_saved
  skip
  assert false, 'Missing test implementation'
 end

 def test_03_error_message_for_missing_title
  skip
  assert false, 'Missing test implementation'
 end

 def test_04_error_message_for_missing_seen?
  skip
  assert false, 'Missing test implementation'
 end

 def test_05_error_message_for_missing_own?
  skip
  assert false, 'Missing test implementation'
 end

 def test_06_error_message_for_missing_wishlist_see?
  skip
  assert false, 'Missing test implementation'
 end

 def test_07_error_message_for_missing_wishlist_own?
  skip
  assert false, 'Missing test implementation'
 end

 def test_08_error_message_for_missing_rating
  skip
  assert false, 'Missing test implementation'
 end

end