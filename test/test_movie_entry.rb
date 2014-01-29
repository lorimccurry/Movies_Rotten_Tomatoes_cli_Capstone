require_relative 'helper'
require_relative '../models/movie_entries'

class TestMovieEntries < MovieTest
  def test_to_s_prints_details
    movie_entry = MovieEntries.new(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    expected = "Foo: seen t, own f, wishlist see f, wishlist own t, user rating: 75, id: #{movie_entry.id}"
    assert_equal expected, movie_entry.to_s
  end

  def test_update_doesnt_insert_new_row
    movie_entry = MovieEntries.create(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    foos_before = database.execute("select count(id) from movie_entries")[0][0]
    movie_entry.update(name: "Bar")
    foos_after = database.execute("select count(id) from movie_entries")[0][0]
    assert_equal foos_before, foos_after
  end


  def test_update_saves_to_the_database
    movie_entry = MovieEntries.create(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    id =  movie_entry.id
    movie_entry.update(title: "Bar", seen: "f", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "67")
    updated_movie_entry = MovieEntries.find(id)
    expected = ["Bar", "f", "f", "f", "t", 67]
    actual = [updated_movie_entry.title, updated_movie_entry.seen, updated_movie_entry.own, updated_movie_entry.wishlist_see, updated_movie_entry.wishlist_own, updated_movie_entry.user_rating]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    movie_entry = MovieEntries.create(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    movie_entry.update(title: "Bar", seen: "f", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "67")
    expected = ["Bar", "f", "f", "f", "t", "67"]
    actual = [movie_entry.title, movie_entry.seen, movie_entry.own, movie_entry.wishlist_see, movie_entry.wishlist_own, movie_entry.user_rating]
    assert_equal expected, actual
  end

  def test_saved_movie_entries_are_saved
    movie_entry = MovieEntries.new(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    foos_before = database.execute("select count(id) from movie_entries")[0][0]
    movie_entry.save
    foos_after = database.execute("select count(id) from movie_entries")[0][0]
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    movie_entry = MovieEntries.create(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    refute_nil movie_entry.id, "Movie entry shouldn't be nil"
  end

  def test_find_returns_nil_if_unfindable
    assert_nil MovieEntries.find(12345)
  end

  def test_find_returns_the_row_as_purchase_object
    movie_entry = MovieEntries.create(title: "Foo", seen: "t", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "75")
    found = MovieEntries.find(movie_entry.id)
    assert_equal movie_entry.title, found.title
    assert_equal movie_entry.id, found.id
  end

  def test_search_returns_purchase_objects
    MovieEntries.create(title: "Erin Brocovich", seen: "t", own: "f", wishlist_see: "t", wishlist_own: "t", user_rating: "42")
    MovieEntries.create(title: "Good Will Hunting", seen: "f", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "67")
    MovieEntries.create(title: "A Good Year", seen: "f", own: "t", wishlist_see: "t", wishlist_own: "f", user_rating: "n/a")
    results = MovieEntries.search("Good")
    assert results.all?{ |result| result.is_a? MovieEntries }, "Not all results were MovieEntries"
  end

  def test_search_returns_appropriate_results
    movie_entry1 = MovieEntries.create(title: "Erin Brocovich", seen: "t", own: "f", wishlist_see: "t", wishlist_own: "t", user_rating: "42")
    movie_entry2 = MovieEntries.create(title: "A Good Year", seen: "f", own: "t", wishlist_see: "t", wishlist_own: "f", user_rating: "n/a")
    movie_entry3 = MovieEntries.create(title: "Good Will Hunting", seen: "f", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "67")
    expected = [movie_entry2, movie_entry3]
    actual = MovieEntries.search("Good")
    assert_equal expected, actual
  end

  def test_search_returns_empty_array_if_no_results
    MovieEntries.create(title: "Erin Brocovich", seen: "t", own: "f", wishlist_see: "t", wishlist_own: "t", user_rating: "42")
    MovieEntries.create(title: "Good Will Hunting", seen: "f", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "67")
    MovieEntries.create(title: "A Good Year", seen: "f", own: "t", wishlist_see: "t", wishlist_own: "f", user_rating: "n/a")
    results = MovieEntries.search("Bad")
    assert_equal [], results
  end

  def test_all_movie_entries_in_alphabetical_order
    MovieEntries.create(title: "foo", seen: "t", own: "f", wishlist_see: "t", wishlist_own: "t", user_rating: "42")
    MovieEntries.create(title: "bar", seen: "f", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "67")
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
    movie_entry = MovieEntries.create(title: "foo", seen: "t", own: "f", wishlist_see: "t", wishlist_own: "t", user_rating: "42")
    assert movie_entry == movie_entry
  end

  def test_equality_with_different_class
    movie_entry = MovieEntries.create(title: "foo", seen: "t", own: "f", wishlist_see: "t", wishlist_own: "t", user_rating: "42")
    refute movie_entry == "Movie Entry"
  end

  def test_equality_with_different_movie_entry
    movie_entry1 = MovieEntries.create(title: "foo", seen: "t", own: "f", wishlist_see: "t", wishlist_own: "t", user_rating: "42")
    movie_entry2 = MovieEntries.create(title: "bar", seen: "f", own: "f", wishlist_see: "f", wishlist_own: "t", user_rating: "67")
    refute movie_entry1 == movie_entry2
  end

  def test_equality_with_same_movie_entry_different_object_id
    movie_entry1 = MovieEntries.create(title: "foo", seen: "t", own: "f", wishlist_see: "t", wishlist_own: "t", user_rating: "42")
    movie_entry2 = MovieEntries.find(movie_entry1.id)
    assert movie_entry1 == movie_entry2
  end
end