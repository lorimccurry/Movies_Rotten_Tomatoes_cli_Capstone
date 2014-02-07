require_relative 'helper'

class TestPrintingMovieDatabase < MovieTest
  def test_01_test_returns_relevant_results
    good_will_hunting = Movie.find_or_create_by(title: "Good Will Hunting", year: "1997", rated: "R", runtime: "126 min", genre: "Drama", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "94", released: "09 Jan 1998", dvd: "08 Dec 1998", production: "Miramax", box_office: "N/A")
    a_good_year = Movie.find_or_create_by(title: "A Good Year", year: "2006", rated: "PG-13", runtime: "117 min", genre: "Comedy, Drama, Romance", tomato_meter: "25", tomato_image: "rotten", tomato_user_meter: "65", released: "10 Nov 2006", dvd: "27 Feb 2007", production: "20th Century Fox", box_office: "$7.4M")
    erin_brockovich = Movie.find_or_create_by(title: "Erin Brockovich", year: "2000", rated: "R", runtime: "131 min", genre: "Biography, Drama", tomato_meter: "84", tomato_image: "certified", tomato_user_meter: "80", released: "17 Mar 2000", dvd: "15 Aug 200", production: "Universal Pictures", box_office: "N/A")

    command = "./movie all"
    expected = <<EOS.chomp
King Splat Ultimate Movie Database:
A Good Year => tomato meter: #{a_good_year.tomato_meter}
Erin Brockovich => tomato meter: #{erin_brockovich.tomato_meter}
Good Will Hunting => tomato meter: #{good_will_hunting.tomato_meter}
EOS
    assert_command_output expected, command
  end
end
