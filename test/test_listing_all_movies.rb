require_relative 'helper'

class TestListingMovies < MovieTest
  def test_01_test_returns_relevant_results
    `./movie add 'Good Will Hunting' -s t -o t --ws f --wo f -r 96 --environment test`
    `./movie add 'A Good Year' -s t -o f --ws f --wo f -r 38 --environment test`
    `./movie add 'Erin Brockovich' -s t -o f --ws f --wo t -r 88 --environment test`

    command = "./movie list"
    expected = <<EOS.chomp
All Movies:
A Good Year: seen t, own f, wishlist see f, wishlist own f, user rating: 38
Erin Brockovich: seen t, own f, wishlist see f, wishlist own t, user rating: 88
Good Will Hunting: seen t, own t, wishlist see f, wishlist own f, user rating: 96
EOS
    assert_command_output expected, command
  end
end
