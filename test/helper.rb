require 'minitest/autorun'

class MovieTest < Minitest::Unit::TestCase
  def database
    @database ||= SQLite3::Database.new("db/movie_test.sqlite3")
  end

  def assert_command_output expected, command
   actual = `#{command}`.strip
   assert_equal expected, actual
  end
end