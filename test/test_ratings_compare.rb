require_relative 'helper'
class TestRatingsCompare < MovieTest
  def test_ratings_compare_produces_relevant_difference
    good_will_hunting = MovieEntries.create(title: "Good Will Hunting", seen: 1, own: 1, wishlist_see: 0, wishlist_own: 0, user_rating: "2", environment: "test")
    a_good_year = MovieEntries.create(title: "A Good Year", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 0, user_rating: "5", environment: "test")
    erin_brockovich = MovieEntries.create(title: "Erin Brockovich", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "8", environment: "test")
    up = MovieEntries.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "32", environment: "test")
    magic_mike = MovieEntries.create(title: "Magic Mike", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "100", environment: "test")
    the_notebook = MovieEntries.create(title: "The Notebook", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "100", environment: "test")
    the_holiday = MovieEntries.create(title: "The Holiday", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "91", environment: "test")
    blood_diamond = MovieEntries.create(title: "Blood Diamond", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "21", environment: "test")
    once = MovieEntries.create(title: "Once", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "15", environment: "test")
    ps_i_love_you = MovieEntries.create(title: "P.S. I Love You", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "89", environment: "test")
    shell_output = ""
    IO.popen('./movie ratings_compare --environment test', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Your taste sucks. Your average critic rating difference is 59%."
  end
end
