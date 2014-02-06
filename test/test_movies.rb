require_relative 'helper'

class TestMovies < MovieTest
  def test_count_when_no_categories
    assert_equal 0, Movie.count
  end

  def test_count_of_multiple_movies
    Movie.find_or_create(title: "Gravity", year: "2013", rated: "PG-13", runtime: "91 min", genre: "Drama, Sci-Fi, Thriller", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "85", released: "04 Oct 2013", dvd: "25 Feb 2014", production: "Warner Bros. Pictures", box_office: "$254.6M")
    Movie.find_or_create(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    Movie.find_or_create(title: "Erin Brockovich", year: "2000", rated: "R", runtime: "131 min", genre: "Biography, Drama", tomato_meter: "84", tomato_image: "certified", tomato_user_meter: "80", released: "17 Mar 2000", dvd: "15 Aug 200", production: "Universal Pictures", box_office: "N/A")
    assert_equal 3, Movie.count
  end

  def test_movies_are_created_if_needed
    foos_before = Movie.count
    Movie.find_or_create(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    foos_after = Movie.count
    assert_equal foos_before + 1, foos_after
  end

  def test_movies_are_not_created_if_they_already_exist
    Movie.find_or_create(title: "Gravity", year: "2013", rated: "PG-13", runtime: "91 min", genre: "Drama, Sci-Fi, Thriller", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "85", released: "04 Oct 2013", dvd: "25 Feb 2014", production: "Warner Bros. Pictures", box_office: "$254.6M")
    foos_before = Movie.count
    Movie.find_or_create(title: "Gravity", year: "2013", rated: "PG-13", runtime: "91 min", genre: "Drama, Sci-Fi, Thriller", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "85", released: "04 Oct 2013", dvd: "25 Feb 2014", production: "Warner Bros. Pictures", box_office: "$254.6M")
    foos_after = Movie.count
    assert_equal foos_before, foos_after
  end

  def test_existing_movie_is_returned_by_find_or_create
    movie1 = Movie.find_or_create(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    movie2 = Movie.find_or_create(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    assert_equal movie1.id, movie2.id, "Movie ids should be identical"
  end

  def test_save_creates_an_id
    movie = Movie.find_or_create(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    refute_nil movie.id, "Movie id shouldn't be nil"
  end

  def test_all_returns_all_movies_in_alphabetical_order
    Movie.find_or_create(title: "Gravity", year: "2013", rated: "PG-13", runtime: "91 min", genre: "Drama, Sci-Fi, Thriller", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "85", released: "04 Oct 2013", dvd: "25 Feb 2014", production: "Warner Bros. Pictures", box_office: "$254.6M")
    Movie.find_or_create(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    expected = ["Gravity",2013,"PG-13","91 min","Drama, Sci-Fi, Thriller", 97,"certified",85,"04 Oct 2013","25 Feb 2014","Warner Bros. Pictures","$254.6M", "Up",2009,"PG","96 min","Animation, Adventure, Drama",98,"certified",89,"29 May 2009","10 Nov 2009","Walt Disney Pictures","$293.0M"]
    actual = Movie.all.map{ |movie| [movie.title, movie.year, movie.rated, movie.runtime, movie.genre, movie.tomato_meter, movie.tomato_image, movie.tomato_user_meter, movie.released, movie.dvd, movie.production, movie.box_office]}.flatten
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_movies
    results = Movie.all
    assert_equal [], results
  end
end
