require_relative 'helper'
require 'sqlite3'

class TestSearchingMovies < MovieTest
  def test_01_test_search_returns_relevant_results
    `./movie add 'Good Will Hunting' -s t -o t --ws f --wo f -r 100 --environment test`
    `./movie add 'A Good Year' -s t -o f --ws f --wo f -r 60 --environment test`
    `./movie add 'Erin Brockovich' -s t -o f --ws f --wo t -r 85 --environment test`

    shell_output = ""
    IO.popen('./movie search', 'r+') do |pipe|
      pipe.puts("Good")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Good Will Hunting", "A Good Year"
    assert_not_in_output shell_output, "Erin Brockovich"
  end
end
