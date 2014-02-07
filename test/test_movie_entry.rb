require_relative 'helper'

class TestMovieEntry < MovieTest
  def test_count_when_no_movie_entries
    assert_equal 0, MovieEntry.count
  end

  def test_count_of_multiple_movie_entries
    MovieEntry.create(title: "Gravity", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    MovieEntry.create(title: "Up", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    MovieEntry.create(title: "Jaws", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "84")
    assert_equal 3, MovieEntry.count
  end

  def test_movie_defaults_to_unknown
    movie_entry = MovieEntry.create(title: "Gravity", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    assert_equal "Unknown", movie_entry.movie.title
  end

  def test_to_s_prints_details
    movie = Movie.find_or_create_by(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    movie_entry = MovieEntry.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    # movie_entry = MovieEntry.new(movie: movie, seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    expected = "Up: seen true, own false, wishlist see false, wishlist own true, user rating: 75, id: #{movie_entry.id}"
    assert_equal expected, movie_entry.to_s
  end

  def test_update_doesnt_insert_new_row
    movie_entry = MovieEntry.create(title: "Foo", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    foos_before = MovieEntry.count
    movie_entry.update(title: "Bar")
    foos_after = MovieEntry.count
    assert_equal foos_before, foos_after
  end

  def test_update_saves_to_the_database
    movie_entry = MovieEntry.create(title: "Gravity", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    id =  movie_entry.id
    movie_entry.update(title: "Up", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    updated_movie_entry = MovieEntry.find(id)
    expected = ["Up", false, false, false, true, "67"]
    actual = [updated_movie_entry.title, updated_movie_entry.seen, updated_movie_entry.own, updated_movie_entry.wishlist_see, updated_movie_entry.wishlist_own, updated_movie_entry.user_rating]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    movie_entry = MovieEntry.create(title: "Foo", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    movie_entry.update(title: "Bar", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    expected = ["Bar", false, false, false, true, "67"]
    actual = [movie_entry.title, movie_entry.seen, movie_entry.own, movie_entry.wishlist_see, movie_entry.wishlist_own, movie_entry.user_rating]
    assert_equal expected, actual
  end

  def test_saved_movie_entries_are_saved
    movie_entry = MovieEntry.new(title: "Foo", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    foos_before = MovieEntry.count
    movie_entry.save
    foos_after = MovieEntry.count
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    movie_entry = MovieEntry.create(title: "Foo", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    refute_nil movie_entry.id, "Movie entry shouldn't be nil"
  end

  def test_save_saves_movie_id
    movie = Movie.find_or_create_by(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    movie_entry = MovieEntry.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75", movie: movie)
    movie_id = MovieEntry.find(movie_entry.id).movie.id
    assert_equal movie.id, movie_id, "Movie.id and movie_entry.movie_id should be the same"
  end

  def test_save_update_movie_id
    movie1 = Movie.find_or_create_by(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    movie2 = Movie.find_or_create_by(title: "Gravity", year: "2013", rated: "PG-13", runtime: "91 min", genre: "Drama, Sci-Fi, Thriller", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "85", released: "04 Oct 2013", dvd: "25 Feb 2014", production: "Warner Bros. Pictures", box_office: "$254.6M")
    movie_entry = MovieEntry.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75", movie: movie1)
    movie_entry.movie = movie2
    movie_entry.save
    movie_id = MovieEntry.find(movie_entry.id).movie.id
    assert_equal movie2.id, movie_id, "Movie2.id and movie_entry.movie_id should be the same"
  end

  def test_find_returns_the_row_as_movie_entry_object
    movie = Movie.find_or_create_by(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    movie_entry = MovieEntry.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    found = MovieEntry.find(movie_entry.id)
    assert_equal movie_entry.title, found.title
    assert_equal movie_entry.id, found.id
    assert_equal movie_entry.seen, found.seen
    assert_equal movie_entry.own, found.own
    assert_equal movie_entry.wishlist_see, found.wishlist_see
    assert_equal movie_entry.wishlist_own, found.wishlist_own
    assert_equal movie_entry.user_rating, found.user_rating
  end

  def test_find_results_the_movie_entry_with_correct_movie
    movie = Movie.find_or_create_by(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    movie_entry = MovieEntry.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75", movie: movie)
    found = MovieEntry.find(movie_entry.id)
    refute_equal Movie.default.id, found.movie.id
    assert_equal movie.id, found.movie.id
  end

  def test_search_returns_movie_entry_objects
    MovieEntry.create(title: "Erin Brocovich", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    MovieEntry.create(title: "Good Will Hunting", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    MovieEntry.create(title: "A Good Year", seen: 1, own: 1, wishlist_see: 1, wishlist_own: 0, user_rating: "n/a")
    results = MovieEntry.search("Good")
    assert results.all?{ |result| result.is_a? MovieEntry }, "Not all results were MovieEntry"
  end

  def test_search_returns_appropriate_results
    movie_entry1 = MovieEntry.create(title: "Erin Brocovich", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    movie_entry2 = MovieEntry.create(title: "A Good Year", seen: 0, own: 1, wishlist_see: 1, wishlist_own: 0, user_rating: "n/a")
    movie_entry3 = MovieEntry.create(title: "Good Will Hunting", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    expected = [movie_entry2, movie_entry3]
    actual = MovieEntry.search("Good")
    assert_equal expected, actual
  end

  def test_search_returns_empty_array_if_no_results
    MovieEntry.create(title: "Erin Brocovich", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    MovieEntry.create(title: "Good Will Hunting", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    MovieEntry.create(title: "A Good Year", seen: 0, own: 1, wishlist_see: 1, wishlist_own: 0, user_rating: "n/a")
    results = MovieEntry.search("Bad")
    assert_equal [], results
  end

  def test_all_movie_entries_in_alphabetical_order
    MovieEntry.create(title: "foo", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    MovieEntry.create(title: "bar", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    results = MovieEntry.all
    expected = ["bar", "foo"]
    actual = results.map{|movie_entry| movie_entry.title}
    assert_equal expected, actual
  end

  def test_all_movies_empty_array_if_no_movies
    results = MovieEntry.all
    assert_equal [], results
  end

  def test_equality_on_same_object
    movie_entry = MovieEntry.create(title: "foo", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    assert movie_entry == movie_entry
  end

  def test_equality_with_different_class
    movie_entry = MovieEntry.create(title: "foo", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    refute movie_entry == "Movie Entry"
  end

  def test_equality_with_different_movie_entry
    movie_entry1 = MovieEntry.create(title: "foo", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    movie_entry2 = MovieEntry.create(title: "bar", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    refute movie_entry1 == movie_entry2
  end

  def test_equality_with_same_movie_entry_different_object_id
    movie_entry1 = MovieEntry.create(title: "foo", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    movie_entry2 = MovieEntry.find(movie_entry1.id)
    assert movie_entry1 == movie_entry2
  end
end