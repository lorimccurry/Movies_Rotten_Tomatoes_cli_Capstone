require_relative 'helper'
require_relative '../lib/importer'

class TestImportingMovieEntries < MovieTest
  def import_data
    Importer.import("test/sample_movie_entry_data.csv")
  end

  def test_the_correct_number_of_movie_entries_are_imported
    import_data
    assert_equal 5, MovieEntries.all.count
  end

  def test_movie_entries_are_imported_fully
    import_data
    expected = [
      "Fight Club, false, false, true, false, none",
      "Magic Mike, true, false, false, false, 10",
      "The Social Network, true, true, false, false, 85",
      "Up, true, false, false, true, 95",
      "When Harry Met Sally, true, true, false, false, 90",
    ]
    actual = MovieEntries.all.map do |movie_entry|
      "#{movie_entry.title}, #{movie_entry.seen}, #{movie_entry.own}, #{movie_entry.wishlist_see}, #{movie_entry.wishlist_own}, #{movie_entry.user_rating}"
    end
    assert_equal expected, actual
  end

  def test_extra_movies_arent_created
    import_data
    assert 5, Movie.all.count
  end

  def test_movies_are_created_as_needed
    Movie.find_or_create("Good Will Hunting")
    Movie.find_or_create("Up")
    import_data
    assert 7, Movie.all.count
  end

  def test_data_isnt_duplicated
    import_data
    expected = ["Fight Club", "Magic Mike", "The Social Network", "Up", "When Harry Met Sally"]
    assert_equal expected, Movie.all.map(&:title)
  end

end