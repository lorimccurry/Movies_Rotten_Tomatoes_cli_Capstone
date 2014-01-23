require 'minitest/autorun'
require_relative '../lib/environment'

class MovieTest < Minitest::Unit::TestCase
  def database
    Environment.database_connection("test")
  end

  def assert_command_output expected, command
   actual = `#{command} --environment test`.strip
   assert_equal expected, actual
  end
end