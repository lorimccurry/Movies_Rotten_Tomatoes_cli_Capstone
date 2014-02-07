require_relative 'helper'
require 'sqlite3'

class TestDeletingMovies < MovieTest
  def test_updating_a_record_that_exists
    movie_entry = MovieEntries.create(title: "Gravity", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    id =  movie_entry.id
    command = "./movie delete --id #{id} --environment test"
    expected = "'Gravity' => id: #{movie_entry.id}, seen: #{movie_entry.seen}, own: #{movie_entry.own}, wishlist see: #{movie_entry.wishlist_see}, wishlist own: #{movie_entry.wishlist_own}, your rating: #{movie_entry.user_rating} has been cut"
    assert_command_output expected, command
  end


  def test_deleting_an_existing_movie_entry
    good_will_hunting_movie = Movie.find_or_create_by(title: "Good Will Hunting", year: "1997", rated: "R", runtime: "126 min", genre: "Drama", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "94", released: "09 Jan 1998", dvd: "08 Dec 1998", production: "Miramax", box_office: "N/A")
    a_good_year_movie = Movie.find_or_create_by(title: "A Good Year", year: "2006", rated: "PG-13", runtime: "117 min", genre: "Comedy, Drama, Romance", tomato_meter: "25", tomato_image: "rotten", tomato_user_meter: "65", released: "10 Nov 2006", dvd: "27 Feb 2007", production: "20th Century Fox", box_office: "$7.4M")
    erin_brockovich_movie = Movie.find_or_create_by(title: "Erin Brockovich", year: "2000", rated: "R", runtime: "131 min", genre: "Biography, Drama", tomato_meter: "84", tomato_image: "certified", tomato_user_meter: "80", released: "17 Mar 2000", dvd: "15 Aug 200", production: "Universal Pictures", box_office: "N/A")

    good_will_hunting = MovieEntries.create(title: "Good Will Hunting", seen: 1, own: 1, wishlist_see: 0, wishlist_own: 0, user_rating: "96", movie: good_will_hunting_movie)
    a_good_year = MovieEntries.create(title: "A Good Year", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 0, user_rating: "38", movie: a_good_year_movie)
    erin_brockovich = MovieEntries.create(title: "Erin Brockovich", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "88", movie: erin_brockovich_movie)

    # id = entries.id
    command = "./movie delete --id #{a_good_year.id}"
    expected = "'A Good Year' => id: #{a_good_year.id}, seen: #{a_good_year.seen}, own: #{a_good_year.own}, wishlist see: #{a_good_year.wishlist_see}, wishlist own: #{a_good_year.wishlist_own}, your rating: #{a_good_year.user_rating} has been cut"
    assert_command_output expected, command
  end
end