##User Stories

###1: Add a new movie to the database
<pre>
As a movie tracker
In order to create a library of my movies
I want to be able to enter a new movie to my movie tracker

Usage: ./movies add_movie -t "Title" -s "t/f" -o "t/f" -ws "t/f" -wo "t/f" -r num

Acceptance criteria:
* User enters title and appropriate flags preceding necessary data
  * -t : Title
  * -s : Seen?
  * -o : Own?
  * -ws : Wishlist see?
  * -wo : Wishlist own?
  * -r : Rating number
* A user is limited to select database list of movies
* Shows user responses at end of data input and asks for confirmation
</pre>
###2: View tracker library and sort/search data
<pre>
As a movie tracker
In order to view the movies in my library
I want to be able to query a movie and existing information on it

Usage: ./movies view_movie "Title"

Acceptance criteria:
* User can query for a specific movie
* Prints all record information on the movie
</pre>
<pre>
As a movie glutton
In order to keep track of the number of movies I've seen
I want to see a total count of movies I've viewed.

Usage: ./movies movie_count

Acceptance criteria:
* User can query for total movies seen
* Prints total movies viewed by user
</pre>
<pre>
As a new-movie consumer
In order to be able to target movies I want to see in theaters or on DVD
I want to to be able to view a list of the movies on my wish-list.

Usage: ./movies wish_list_movies

Acceptance criteria:
* User can query for wish list
* Will print wish list movies alphabetically
* Movies outside filter criteria won't be returned (in any query)
* If sort produces no results a 'no results' message returns (in any query)
</pre>
<pre>
As a movie lender
In order to be able to view what movies I own
I want to be able to view a list of my owned movie library.

Usage: ./movies owned_movies

Acceptance criteria:
* User can query owned movies
* Will print movies user owns
</pre>
<pre>
As a movie recommender
In order to give advice based on movies I've seen
I want to be able to view my ratings by genre.

Usage: ./movies my_rating "Genre"

Acceptance criteria:
* User can query by ratings and genre
* Prints movies in genre with user rating
</pre>
<pre>
As a researcher of opinions of movie critics and other movie goers
In order to decide if a movie is one I want to see
I want to be able to view Rotten Tomatoes critic and user ratings.

Usage: ./movies rt_ratings "Title"

Acceptance criteria:
* User can query a movie for RT ratings
* Prints movie name and RT critic and user ratings
</pre>
<pre>
As a movie critic
In order to get a gauge of how I'm performing
I want to be able to compare my movie rating skills to those of
other rotten tomatoes critics and user ratings.

Usage: ./movies ratings_compare

Acceptance criteria:
* User can query for report of movies they have rated
* Prints list of user-rated movies with user rating and RT ratings
* Prints difference between user and RT ratings overall
</pre>
### 3: Updating movies from the database
<pre>
As a movie tracker
In order to keep my library current
I want to be able to edit a movie field

Usage: ./movies edit_movie "Title"

Acceptance criteria:
* User enters movie title for edit
* Prints current movie record and prompts user for which field(s) for edit
* User enters appropriate flags preceding new data to replace existing values
  * -t : Title
  * -s : Seen?
  * -o : Own?
  * -ws : Wishlist see?
  * -wo : Wishlist own?
  * -r : Rating number
</pre>

###4: Deleting movies from the database
<pre>
As a movie tracker
In order to remove movies from my library
I want to be able to delete a movie in my library

Usage: ./movies delete_movie "Title"

Acceptance criteria:
* User enters movie title to be deleted
* Prints movie record and asks user to confirm deletion
</pre>