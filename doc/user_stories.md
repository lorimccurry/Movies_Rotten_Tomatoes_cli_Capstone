##User Stories

### Feature 1: Build your own movie tracker library
<pre>
As a movie tracker
In order to track movies I've seen in the theater, own, or want to for either
I want to be able to log and categorize a collection of my movies and theater movies.

Acceptance criteria:
* A user is associated with an entry
* A user can enter or select a movie title
* A user can enter they've seen or not seen a movie
* A user can enter they own or don't own a movie
* A user can enter if they want to see or own a movie
* A user is limited to select database list of movies
* A user can update any fields they input for a given movie
</pre>
<pre>
As a movie recommender
In order to give advice based on movies I've seen
I want to be able to rate movies

Acceptance criteria:
* A user can enter a numeric movie rating 1-100
* A user can choose to leave this field blank
</pre>

### Feature 2: View tracker library and sort/search data
<pre>
As a movie glutton
In order to keep track of the number of movies I've seen
I want to see a total count of movies I've viewed.
     
Acceptance criteria:
* User can query for total movies seen
* Prints total movies viewed by user
</pre>
<pre>
As a new-movie consumer
In order to be able to target movies I want to see in theaters or that I own
I want to to be able to view a list of the movies on my wish-list.

Acceptance criteria:
* User can query and will print wish list items
* Movies outside filter criteria won't be returned (in any query)
* If sort produces no results a 'no results' message returns (in any query)
</pre>
<pre>
As a movie lender
In order to be able to view what movies I own
I want to be able to view a list of my owned movie library.

Acceptance criteria:
* User can query owned movies
* Will print movies user owns
</pre>
<pre>
As a movie recommender
In order to give advice based on movies I've seen
I want to be able to view my ratings by genre.

Acceptance criteria:
* User can query by ratings and genre
* Prints movies in genre with user rating
</pre>

### Feature 3: Rotten Tomatoes rating shown in for movies in tracker
<pre>
As a researcher of opinions of movie critics and other movie goers
In order to decide if a movie is one I want to see
I want to be able to view Rotten Tomatoes critic and user ratings.

Acceptance criteria:
* User can query a movie for RT ratings
* Prints movie name and RT critic and user ratings
</pre>
<pre>
As a movie critic
In order to get a gauge of how I'm performing
I want to be able to compare my movie rating skills to those of
other rotten tomatoes critics and user ratings.

Acceptance criteria:
* Print difference between user and RT ratings overall
* Will not factor differences for movies that have not been rated
</pre>
