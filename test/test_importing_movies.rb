require_relative 'helper'
require_relative '../lib/importer'
# require_relative '../models/movie'

class TestImportingMovies < MovieTest
  def import_data
    Importer.import("test/sample_movie_data.csv")
  end

  def test_the_correct_number_of_movies_are_imported
    import_data
    assert_equal 5, MovieEntries.all.count
  end

  def test_products_are_imported_fully
    import_data
    expected = ["Up,t,f,f,t,95",
    "The Social Network,t,t,f,f,85",
    "Fight Club,f,f,t,f,N/A",
    "When Harry Met Sally,t,t,f,f,90",
    "Magic Mike,t,f,f,f,10"]
    actual = MovieEntries.all.map do |movie_entry|
      "#{movie_entry.title}, #{movie_entry.seen}, #{movie_entry.own}, #{movie_entry.wishlist_see}, #{movie_entry.wishlist_own}, #{movie_entry.user_rating}"
    end
    assert_equal expected, actual
  end

  def test_extra_movies_arent_created
    import_data
    assert 5, Movie.nil.count
  end

  def test_movies_are_created_as_needed
    Movie.create("Good Will Hunting")
    Movie.create("Up")
    import_data
    assert 7, Movie.all.count
  end

  def test_data_isnt_duplicated
    import_data
    expected = ["Good Will Hunting", "American Hustle", "Up"]
    assert_equal expected, Movie.all.map(&:movie)
  end

end