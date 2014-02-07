require_relative 'helper'
class TestRatingsCompare < MovieTest
  def test_ratings_compare_produces_poor_rating_difference
    up_movie = Movie.find_or_create_by(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    good_will_hunting_movie = Movie.find_or_create_by(title: "Good Will Hunting", year: "1997", rated: "R", runtime: "126 min", genre: "Drama", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "94", released: "09 Jan 1998", dvd: "08 Dec 1998", production: "Miramax", box_office: "N/A")
    a_good_year_movie = Movie.find_or_create_by(title: "A Good Year", year: "2006", rated: "PG-13", runtime: "117 min", genre: "Comedy, Drama, Romance", tomato_meter: "25", tomato_image: "rotten", tomato_user_meter: "65", released: "10 Nov 2006", dvd: "27 Feb 2007", production: "20th Century Fox", box_office: "$7.4M")
    erin_brockovich_movie = Movie.find_or_create_by(title: "Erin Brockovich", year: "2000", rated: "R", runtime: "131 min", genre: "Biography, Drama", tomato_meter: "84", tomato_image: "certified", tomato_user_meter: "80", released: "17 Mar 2000", dvd: "15 Aug 200", production: "Universal Pictures", box_office: "N/A")
    magic_mike_movie = Movie.find_or_create_by(title: "Magic Mike", year: "2012", rated: "R", runtime: "110 min", genre: "Comedy, Drama", tomato_meter: "80", tomato_image: "certified", tomato_user_meter: "61", released: "29 Jun 2012", dvd: "23 Oct 2012", production: "Warner Bros. Pictures", box_office: "$113.7M")
    the_notebook_movie = Movie.find_or_create_by(title: "The Notebook", year: "2004", rated: "PG-13", runtime: "123 min", genre: "Drama, Romance", tomato_meter: "52", tomato_image: "rotten", tomato_user_meter: "85", released: "25 Jun 2004", dvd: "N/A", production: "N/A", box_office: "N/A")
    the_holiday_movie = Movie.find_or_create_by(title: "The Holiday", year: "2006", rated: "PG-13", runtime: "138 min", genre: "Comedy, Romance", tomato_meter: "47", tomato_image: "rotten", tomato_user_meter: "80", released: "08 Dec 2006", dvd: "13 Mar 2007", production: "Sony Pictures", box_office: "$63.2M")
    blood_diamond_movie = Movie.find_or_create_by(title: "Blood Diamond", year: "2006", rated: "R", runtime: "143 min", genre: "Adventure, Drama, Thriller", tomato_meter: "62", tomato_image: "fresh", tomato_user_meter: "90", released: "08 Dec 2006", dvd: "20 Mar 2007", production: "Warner Bros. Pictures", box_office: "$57.3M")
    once_movie = Movie.find_or_create_by(title: "Once", year: "2006", rated: "R", runtime: "85 min", genre: "Drama, Music, Romance", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "91", released: "23 Mar 2007", dvd: "18 Dec 2007", production: "Fox Searchlight", box_office: "$9.2M")
    ps_i_love_you_movie = Movie.find_or_create_by(title: "P.S. I Love You", year: "2007", rated: "PG-13", runtime: "126 min", genre: "Drama, Romance", tomato_meter: "24", tomato_image: "rotten", tomato_user_meter: "80", released: "21 Dec 2007", dvd: "N/A", production: "N/A", box_office: "N/A")
    american_hustle_movie = Movie.find_or_create_by(title: "American Hustle", year: "2013", rated: "R", runtime: "138 min", genre: "Crime, Drama", tomato_meter: "92", tomato_image: "certified", tomato_user_meter: "81", released: "20 Dec 2013", dvd: "N/A", production: "Sony Pictures", box_office: "$87.9M")

    good_will_hunting = MovieEntries.create(title: "Good Will Hunting", seen: 1, own: 1, wishlist_see: 0, wishlist_own: 0, user_rating: "2", movie: good_will_hunting_movie)
    a_good_year = MovieEntries.create(title: "A Good Year", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 0, user_rating: "5", movie: a_good_year_movie)
    erin_brockovich = MovieEntries.create(title: "Erin Brockovich", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "8", movie: erin_brockovich_movie)
    up = MovieEntries.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "32", movie: up_movie)
    magic_mike = MovieEntries.create(title: "Magic Mike", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "100", movie: magic_mike_movie)
    the_notebook = MovieEntries.create(title: "The Notebook", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "100", movie: the_notebook_movie)
    the_holiday = MovieEntries.create(title: "The Holiday", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "91", movie: the_holiday_movie)
    blood_diamond = MovieEntries.create(title: "Blood Diamond", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "21", movie: blood_diamond_movie)
    once = MovieEntries.create(title: "Once", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "15", movie: once_movie)
    ps_i_love_you = MovieEntries.create(title: "P.S. I Love You", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "89", movie: ps_i_love_you_movie)
    american_hustle = MovieEntries.create(title: "American Hustle", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "none", movie: american_hustle_movie)

    shell_output = ""
    IO.popen('./movie ratings_compare --environment test', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output,
"*****Ratings Compare: Can I move to L.A., yet?*****

'Good Will Hunting',  your rating: 2,  rt critic rating: 97
'A Good Year',  your rating: 5,  rt critic rating: 25
'Erin Brockovich',  your rating: 8,  rt critic rating: 84
'Up',  your rating: 32,  rt critic rating: 98
'Magic Mike',  your rating: 100,  rt critic rating: 80
'The Notebook',  your rating: 100,  rt critic rating: 52
'The Holiday',  your rating: 91,  rt critic rating: 47
'Blood Diamond',  your rating: 21,  rt critic rating: 62
'Once',  your rating: 15,  rt critic rating: 97
'P.S. I Love You',  your rating: 89,  rt critic rating: 24

Splat! Your taste sucks. Your average critic rating difference is 55."
  end

  def test_ratings_compare_produces_best_rating_difference
    up_movie = Movie.find_or_create_by(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    good_will_hunting_movie = Movie.find_or_create_by(title: "Good Will Hunting", year: "1997", rated: "R", runtime: "126 min", genre: "Drama", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "94", released: "09 Jan 1998", dvd: "08 Dec 1998", production: "Miramax", box_office: "N/A")
    a_good_year_movie = Movie.find_or_create_by(title: "A Good Year", year: "2006", rated: "PG-13", runtime: "117 min", genre: "Comedy, Drama, Romance", tomato_meter: "25", tomato_image: "rotten", tomato_user_meter: "65", released: "10 Nov 2006", dvd: "27 Feb 2007", production: "20th Century Fox", box_office: "$7.4M")
    erin_brockovich_movie = Movie.find_or_create_by(title: "Erin Brockovich", year: "2000", rated: "R", runtime: "131 min", genre: "Biography, Drama", tomato_meter: "84", tomato_image: "certified", tomato_user_meter: "80", released: "17 Mar 2000", dvd: "15 Aug 200", production: "Universal Pictures", box_office: "N/A")
    magic_mike_movie = Movie.find_or_create_by(title: "Magic Mike", year: "2012", rated: "R", runtime: "110 min", genre: "Comedy, Drama", tomato_meter: "80", tomato_image: "certified", tomato_user_meter: "61", released: "29 Jun 2012", dvd: "23 Oct 2012", production: "Warner Bros. Pictures", box_office: "$113.7M")
    the_notebook_movie = Movie.find_or_create_by(title: "The Notebook", year: "2004", rated: "PG-13", runtime: "123 min", genre: "Drama, Romance", tomato_meter: "52", tomato_image: "rotten", tomato_user_meter: "85", released: "25 Jun 2004", dvd: "N/A", production: "N/A", box_office: "N/A")
    the_holiday_movie = Movie.find_or_create_by(title: "The Holiday", year: "2006", rated: "PG-13", runtime: "138 min", genre: "Comedy, Romance", tomato_meter: "47", tomato_image: "rotten", tomato_user_meter: "80", released: "08 Dec 2006", dvd: "13 Mar 2007", production: "Sony Pictures", box_office: "$63.2M")
    blood_diamond_movie = Movie.find_or_create_by(title: "Blood Diamond", year: "2006", rated: "R", runtime: "143 min", genre: "Adventure, Drama, Thriller", tomato_meter: "62", tomato_image: "fresh", tomato_user_meter: "90", released: "08 Dec 2006", dvd: "20 Mar 2007", production: "Warner Bros. Pictures", box_office: "$57.3M")
    once_movie = Movie.find_or_create_by(title: "Once", year: "2006", rated: "R", runtime: "85 min", genre: "Drama, Music, Romance", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "91", released: "23 Mar 2007", dvd: "18 Dec 2007", production: "Fox Searchlight", box_office: "$9.2M")
    ps_i_love_you_movie = Movie.find_or_create_by(title: "P.S. I Love You", year: "2007", rated: "PG-13", runtime: "126 min", genre: "Drama, Romance", tomato_meter: "24", tomato_image: "rotten", tomato_user_meter: "80", released: "21 Dec 2007", dvd: "N/A", production: "N/A", box_office: "N/A")
    american_hustle_movie = Movie.find_or_create_by(title: "American Hustle", year: "2013", rated: "R", runtime: "138 min", genre: "Crime, Drama", tomato_meter: "92", tomato_image: "certified", tomato_user_meter: "81", released: "20 Dec 2013", dvd: "N/A", production: "Sony Pictures", box_office: "$87.9M")

    good_will_hunting = MovieEntries.create(title: "Good Will Hunting", seen: 1, own: 1, wishlist_see: 0, wishlist_own: 0, user_rating: "92", movie: good_will_hunting_movie)
    a_good_year = MovieEntries.create(title: "A Good Year", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 0, user_rating: "28", movie: a_good_year_movie)
    erin_brockovich = MovieEntries.create(title: "Erin Brockovich", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "85", movie: erin_brockovich_movie)
    up = MovieEntries.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "95", movie: up_movie)
    magic_mike = MovieEntries.create(title: "Magic Mike", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75", movie: magic_mike_movie)
    the_notebook = MovieEntries.create(title: "The Notebook", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "57", movie: the_notebook_movie)
    the_holiday = MovieEntries.create(title: "The Holiday", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "50", movie: the_holiday_movie)
    blood_diamond = MovieEntries.create(title: "Blood Diamond", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "75", movie: blood_diamond_movie)
    once = MovieEntries.create(title: "Once", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "60", movie: once_movie)
    ps_i_love_you = MovieEntries.create(title: "P.S. I Love You", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "25", movie: ps_i_love_you_movie)
    american_hustle = MovieEntries.create(title: "American Hustle", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "none", movie: american_hustle_movie)

    shell_output = ""
    IO.popen('./movie ratings_compare --environment test', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output,
"*****Ratings Compare: Can I move to L.A., yet?*****

'Good Will Hunting',  your rating: 92,  rt critic rating: 97
'A Good Year',  your rating: 28,  rt critic rating: 25
'Erin Brockovich',  your rating: 85,  rt critic rating: 84
'Up',  your rating: 95,  rt critic rating: 98
'Magic Mike',  your rating: 75,  rt critic rating: 80
'The Notebook',  your rating: 57,  rt critic rating: 52
'The Holiday',  your rating: 50,  rt critic rating: 47
'Blood Diamond',  your rating: 75,  rt critic rating: 62
'Once',  your rating: 60,  rt critic rating: 97
'P.S. I Love You',  your rating: 25,  rt critic rating: 24

Fresh! Quit your day job and move to Hollywood.. Your average critic rating difference is 7."
  end

  def test_ratings_compare_produces_mid_rating_difference
    up_movie = Movie.find_or_create_by(title: "Up", year: "2009", rated: "PG", runtime: "96 min", genre: "Animation, Adventure, Drama", tomato_meter: "98", tomato_image: "certified", tomato_user_meter: "89", released: "29 May 2009", dvd: "10 Nov 2009", production: "Walt Disney Pictures", box_office: "$293.0M")
    good_will_hunting_movie = Movie.find_or_create_by(title: "Good Will Hunting", year: "1997", rated: "R", runtime: "126 min", genre: "Drama", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "94", released: "09 Jan 1998", dvd: "08 Dec 1998", production: "Miramax", box_office: "N/A")
    a_good_year_movie = Movie.find_or_create_by(title: "A Good Year", year: "2006", rated: "PG-13", runtime: "117 min", genre: "Comedy, Drama, Romance", tomato_meter: "25", tomato_image: "rotten", tomato_user_meter: "65", released: "10 Nov 2006", dvd: "27 Feb 2007", production: "20th Century Fox", box_office: "$7.4M")
    erin_brockovich_movie = Movie.find_or_create_by(title: "Erin Brockovich", year: "2000", rated: "R", runtime: "131 min", genre: "Biography, Drama", tomato_meter: "84", tomato_image: "certified", tomato_user_meter: "80", released: "17 Mar 2000", dvd: "15 Aug 200", production: "Universal Pictures", box_office: "N/A")
    magic_mike_movie = Movie.find_or_create_by(title: "Magic Mike", year: "2012", rated: "R", runtime: "110 min", genre: "Comedy, Drama", tomato_meter: "80", tomato_image: "certified", tomato_user_meter: "61", released: "29 Jun 2012", dvd: "23 Oct 2012", production: "Warner Bros. Pictures", box_office: "$113.7M")
    the_notebook_movie = Movie.find_or_create_by(title: "The Notebook", year: "2004", rated: "PG-13", runtime: "123 min", genre: "Drama, Romance", tomato_meter: "52", tomato_image: "rotten", tomato_user_meter: "85", released: "25 Jun 2004", dvd: "N/A", production: "N/A", box_office: "N/A")
    the_holiday_movie = Movie.find_or_create_by(title: "The Holiday", year: "2006", rated: "PG-13", runtime: "138 min", genre: "Comedy, Romance", tomato_meter: "47", tomato_image: "rotten", tomato_user_meter: "80", released: "08 Dec 2006", dvd: "13 Mar 2007", production: "Sony Pictures", box_office: "$63.2M")
    blood_diamond_movie = Movie.find_or_create_by(title: "Blood Diamond", year: "2006", rated: "R", runtime: "143 min", genre: "Adventure, Drama, Thriller", tomato_meter: "62", tomato_image: "fresh", tomato_user_meter: "90", released: "08 Dec 2006", dvd: "20 Mar 2007", production: "Warner Bros. Pictures", box_office: "$57.3M")
    once_movie = Movie.find_or_create_by(title: "Once", year: "2006", rated: "R", runtime: "85 min", genre: "Drama, Music, Romance", tomato_meter: "97", tomato_image: "certified", tomato_user_meter: "91", released: "23 Mar 2007", dvd: "18 Dec 2007", production: "Fox Searchlight", box_office: "$9.2M")
    ps_i_love_you_movie = Movie.find_or_create_by(title: "P.S. I Love You", year: "2007", rated: "PG-13", runtime: "126 min", genre: "Drama, Romance", tomato_meter: "24", tomato_image: "rotten", tomato_user_meter: "80", released: "21 Dec 2007", dvd: "N/A", production: "N/A", box_office: "N/A")
    american_hustle_movie = Movie.find_or_create_by(title: "American Hustle", year: "2013", rated: "R", runtime: "138 min", genre: "Crime, Drama", tomato_meter: "92", tomato_image: "certified", tomato_user_meter: "81", released: "20 Dec 2013", dvd: "N/A", production: "Sony Pictures", box_office: "$87.9M")

    good_will_hunting = MovieEntries.create(title: "Good Will Hunting", seen: 1, own: 1, wishlist_see: 0, wishlist_own: 0, user_rating: "62", movie: good_will_hunting_movie)
    a_good_year = MovieEntries.create(title: "A Good Year", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 0, user_rating: "58", movie: a_good_year_movie)
    erin_brockovich = MovieEntries.create(title: "Erin Brockovich", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "85", movie: erin_brockovich_movie)
    up = MovieEntries.create(title: "Up", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "65", movie: up_movie)
    magic_mike = MovieEntries.create(title: "Magic Mike", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "45", movie: magic_mike_movie)
    the_notebook = MovieEntries.create(title: "The Notebook", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "97", movie: the_notebook_movie)
    the_holiday = MovieEntries.create(title: "The Holiday", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "20", movie: the_holiday_movie)
    blood_diamond = MovieEntries.create(title: "Blood Diamond", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "45", movie: blood_diamond_movie)
    once = MovieEntries.create(title: "Once", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "90", movie: once_movie)
    ps_i_love_you = MovieEntries.create(title: "P.S. I Love You", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "55", movie: ps_i_love_you_movie)
    american_hustle = MovieEntries.create(title: "American Hustle", seen: 1, own: 0, wishlist_see: 0, wishlist_own: 1, user_rating: "none", movie: american_hustle_movie)

    shell_output = ""
    IO.popen('./movie ratings_compare --environment test', 'r+') do |pipe|
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output,
"*****Ratings Compare: Can I move to L.A., yet?*****

'Good Will Hunting',  your rating: 62,  rt critic rating: 97
'A Good Year',  your rating: 58,  rt critic rating: 25
'Erin Brockovich',  your rating: 85,  rt critic rating: 84
'Up',  your rating: 65,  rt critic rating: 98
'Magic Mike',  your rating: 45,  rt critic rating: 80
'The Notebook',  your rating: 97,  rt critic rating: 52
'The Holiday',  your rating: 20,  rt critic rating: 47
'Blood Diamond',  your rating: 45,  rt critic rating: 62
'Once',  your rating: 90,  rt critic rating: 97
'P.S. I Love You',  your rating: 55,  rt critic rating: 24

Ripening! Eat more popcorn. Your average critic rating difference is 26."
  end
end
