require_relative 'helper'

class TestMovieEntries < MovieTest
  def test_to_s_prints_details
    movie = Movie.find_or_create(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    movie_entry = MovieEntries.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    # movie_entry = MovieEntries.new(movie: movie, seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    expected = "Up: seen true, own false, wishlist see false, wishlist own true, user rating: 75, id: #{movie_entry.id}"
    assert_equal expected, movie_entry.to_s
  end

  def test_update_doesnt_insert_new_row
    movie_entry = MovieEntries.create(title: "Foo", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    foos_before = database.execute("select count(id) from movie_entries")[0][0]
    movie_entry.update(name: "Bar")
    foos_after = database.execute("select count(id) from movie_entries")[0][0]
    assert_equal foos_before, foos_after
  end

  def test_update_saves_to_the_database
    movie_entry = MovieEntries.create(title: "Gravity", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    id =  movie_entry.id
    movie_entry.update(title: "Up", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    updated_movie_entry = MovieEntries.find(id)
    expected = ["Up", false, false, false, true, "67"]
    actual = [updated_movie_entry.title, updated_movie_entry.seen, updated_movie_entry.own, updated_movie_entry.wishlist_see, updated_movie_entry.wishlist_own, updated_movie_entry.user_rating]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    movie_entry = MovieEntries.create(title: "Foo", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    movie_entry.update(title: "Bar", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    expected = ["Bar", false, false, false, true, "67"]
    actual = [movie_entry.title, movie_entry.seen, movie_entry.own, movie_entry.wishlist_see, movie_entry.wishlist_own, movie_entry.user_rating]
    assert_equal expected, actual
  end

  def test_saved_movie_entries_are_saved
    movie_entry = MovieEntries.new(title: "Foo", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    foos_before = database.execute("select count(id) from movie_entries")[0][0]
    movie_entry.save
    foos_after = database.execute("select count(id) from movie_entries")[0][0]
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    movie_entry = MovieEntries.create(title: "Foo", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    refute_nil movie_entry.id, "Movie entry shouldn't be nil"
  end

  def test_save_saves_movie_id
    movie = Movie.find_or_create(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    movie_entry = MovieEntries.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75", movie: movie)
    movie_id = database.execute("select movie_id from movie_entries where id='#{movie_entry.id}'")[0][0]
    assert_equal movie.id, movie_id, "Movie.id and movie_entry.movie_id should be the same"
  end

  def test_save_update_movie_id
    movie1 = Movie.find_or_create(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    movie2 = Movie.find_or_create(title: "Gravity", year: "2013", rated: "PG-13", runtime: "91 min", genre: "Drama, Sci-Fi, Thriller", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "85", released: "04 Oct 2013", dvd: "25 Feb 2014", production: "Warner Bros. Pictures", box_office: "$254.6M")
    movie_entry = MovieEntries.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75", movie: movie1)
    movie_entry.movie = movie2
    movie_entry.save
    movie_id = database.execute("select movie_id from movie_entries where id='#{movie_entry.id}'")[0][0]
    assert_equal movie2.id, movie_id, "Movie2.id and movie_entry.movie_id should be the same"
  end

  def test_find_returns_nil_if_unfindable
    assert_nil MovieEntries.find(12345)
  end

  def test_find_returns_the_row_as_purchase_object
    movie_entry = MovieEntries.create(title: "Foo", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75")
    found = MovieEntries.find(movie_entry.id)
    assert_equal movie_entry.title, found.title
    assert_equal movie_entry.id, found.id
  end

  def test_search_returns_purchase_objects
    MovieEntries.create(title: "Erin Brocovich", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    MovieEntries.create(title: "Good Will Hunting", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    MovieEntries.create(title: "A Good Year", seen: 1, own: 1, wishlist_see: 1, wishlist_own: 0, user_rating: "n/a")
    results = MovieEntries.search("Good")
    assert results.all?{ |result| result.is_a? MovieEntries }, "Not all results were MovieEntries"
  end

  def test_search_returns_appropriate_results
    movie_entry1 = MovieEntries.create(title: "Erin Brocovich", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    movie_entry2 = MovieEntries.create(title: "A Good Year", seen: 0, own: 1, wishlist_see: 1, wishlist_own: 0, user_rating: "n/a")
    movie_entry3 = MovieEntries.create(title: "Good Will Hunting", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    expected = [movie_entry2, movie_entry3]
    actual = MovieEntries.search("Good")
    assert_equal expected, actual
  end

  def test_search_returns_empty_array_if_no_results
    MovieEntries.create(title: "Erin Brocovich", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    MovieEntries.create(title: "Good Will Hunting", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    MovieEntries.create(title: "A Good Year", seen: 0, own: 1, wishlist_see: 1, wishlist_own: 0, user_rating: "n/a")
    results = MovieEntries.search("Bad")
    assert_equal [], results
  end

  def test_all_movie_entries_in_alphabetical_order
    MovieEntries.create(title: "foo", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    MovieEntries.create(title: "bar", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    results = MovieEntries.all
    expected = ["bar", "foo"]
    actual = results.map{|movie_entry| movie_entry.title}
    assert_equal expected, actual
  end

  def test_all_movies_empty_array_if_no_movies
    results = MovieEntries.all
    assert_equal [], results
  end

  def test_equality_on_same_object
    movie_entry = MovieEntries.create(title: "foo", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    assert movie_entry == movie_entry
  end

  def test_equality_with_different_class
    movie_entry = MovieEntries.create(title: "foo", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    refute movie_entry == "Movie Entry"
  end

  def test_equality_with_different_movie_entry
    movie_entry1 = MovieEntries.create(title: "foo", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    movie_entry2 = MovieEntries.create(title: "bar", seen: 0, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "67")
    refute movie_entry1 == movie_entry2
  end

  def test_equality_with_same_movie_entry_different_object_id
    movie_entry1 = MovieEntries.create(title: "foo", seen: 1, own: 0, wishlist_see: 1, wishlist_own: 1, user_rating: "42")
    movie_entry2 = MovieEntries.find(movie_entry1.id)
    assert movie_entry1 == movie_entry2
  end
end