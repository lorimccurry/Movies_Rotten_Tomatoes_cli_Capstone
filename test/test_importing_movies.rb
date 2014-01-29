require_relative 'helper'
require_relative '../lib/importer'

class TestImportingMovies < MovieTest
  def import_data
    Importer.import("test/sample_movie_data.csv")
  end

  def test_the_correct_number_of_products_are_imported
    skip
    import_data
    assert 5, Movie.all.count
  end

  def test_products_are_imported_fully
    skip
    import_data
    expected = ["Her,2013,Drama,126 min,R,94,86,fresh",
      "August Osage County,2013,Drama,130 min,R,65,72,fresh",
      "Labor Day,2013,Romance,111 min,PG-13,59,93,rotten",
      "When Harry Met Sally,1989,Comedy,96 min,R,88,89,fresh",
      "Dirty Dancing,1987,Drama,85 min,PG-13,72,91,fresh"]
    actual = Movie.all.map do |movie|
      "#{movie.title}, #{movie.year}, #{movie.genre}, #{movie.runtime}, #{movie.rated}, #{movie.tomato}, #{movie.tomato_user_meter}, #{movie.tomato_image}"
    end
    assert_equal expected, actual
  end

  def test_extra_genres_arent_created
    skip
    import_data
    assert 3, Genre.all.count
  end

  def test_genres_are_created_as_needed
    skip
    Genre.create("Drama")
    Genre.create("Horror")
    import_data
    assert 4, Genre.all.count
  end

  def test_data_isnt_duplicated
    skip
    import_data
    expected = ["Drama", "Romance", "Comedy"]
    assert_equal expected, Genre.all.map(&:title)
  end
end