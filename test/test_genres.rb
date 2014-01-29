require_relative 'helper'
require_relative '../models/genre'

class TestGenres < MovieTest
  def test_genres_are_created
    foos_before = database.execute("select count(id) from genres")[0][0]
    Genre.create(name: "Foo")
    foos_after = database.execute("select count(id) from genres")[0][0]
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    genre = Genre.create(name: "Foo")
    refute_nil genre.id, "Genre entry shouldn't be nil"
  end

  def test_all_returns_all_genres_in_alphabetical_order
    Genre.create(name: "foo")
    Genre.create(name: "bar")
    expected = ["bar", "foo"]
    actual = Genre.all.map{ |genre| genre.name}
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_categories
    results = Genre.all
    assert_equal [], results
  end

end
