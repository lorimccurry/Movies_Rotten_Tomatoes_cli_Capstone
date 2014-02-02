require_relative 'helper'

class TestListingMovies < MovieTest
  def test_01_test_returns_relevant_results
    good_will_hunting = MovieEntries.create(title: "Good Will Hunting", seen: 1, own: 1, wishlist_see: 0, wishlist_own: 0, user_rating: "96", environment: "test")
    a_good_year = MovieEntries.create(title: "A Good Year", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 0, user_rating: "38", environment: "test")
    erin_brockovich = MovieEntries.create(title: "Erin Brockovich", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "88", environment: "test")

    command = "./movie list"
    expected = <<EOS.chomp
All Movies:
A Good Year: seen true, own false, wishlist see false, wishlist own false, user rating: 38, id: #{a_good_year.id}
Erin Brockovich: seen true, own false, wishlist see false, wishlist own true, user rating: 88, id: #{erin_brockovich.id}
Good Will Hunting: seen true, own true, wishlist see false, wishlist own false, user rating: 96, id: #{good_will_hunting.id}
EOS
    assert_command_output expected, command
  end
end
