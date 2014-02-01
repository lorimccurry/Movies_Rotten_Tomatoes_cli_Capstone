require_relative 'helper'

class TestListingMovies < MovieTest
  def test_01_test_returns_relevant_results
    good_will_hunting = MovieEntries.create(title: "Good Will Hunting", seen: "true", own: "true", wishlist_see: "false", wishlist_own: "false", user_rating: "96", environment: "test")
    a_good_year = MovieEntries.create(title: "A Good Year", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "f", user_rating: "38", environment: "test")
    erin_brockovich = MovieEntries.create(title: "Erin Brockovich", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "88", environment: "test")

    command = "./movie list"
    expected = <<EOS.chomp
All Movies:
A Good Year: seen t, own f, wishlist see f, wishlist own f, user rating: 38, id: #{a_good_year.id}
Erin Brockovich: seen t, own f, wishlist see f, wishlist own t, user rating: 88, id: #{erin_brockovich.id}
Good Will Hunting: seen true, own true, wishlist see false, wishlist own false, user rating: 96, id: #{good_will_hunting.id}
EOS
    assert_command_output expected, command
  end
end
