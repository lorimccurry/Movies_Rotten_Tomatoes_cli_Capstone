# User Stories

## Feature 1: Build your own movie tracker library

  * As a movie tracker
    In order to track movies I've seen in the theater, own,
    or want to for either
    I want to be able to log and categorize a collection of
    my movies and theater movies.
    -Acceptance criteria:
      *A user can attach their name to an entry
      *A user can enter or select a movie title
      *A user can enter they've seen or not seen a movie
      *A user can enter they own or don't own a movie
      *A user can enter if they want to see or own a movie
      *A user can leave any of these fields blank
      *Limit user to select database list of movies

  * As a movie recommender
    In order to give advice based on movies I've seen
    I want to be able to rate movies
    -Acceptance criteria:
      *A user can enter a numeric movie rating
      *A user can leave this field blank


## Feature 2: View tracker library and sort/search data

  * As a movie glutton
    In order to keep track of the number of movies I've seen
    I want to see a total count of movies I've viewed.
    -Acceptance criteria:
      *Filters by name
      *Prints total movies viewed

  * As a new-movie consumer
    In order to be able to target movies I want to see or own
    I want to to be able to view a list of the movies on my wish-list.
    -Acceptance criteria:
      *User can sort wish list items
      *User can separate wish list theater movies from DVD movies
      *Movies that don't apply based on filter criteria can't be seen
        (in any filter case)
      *If sort produces no results a 'no results' message returns

  * As a movie lender
    In order to be able to view what movies I own
    I want to be able to view a list of my owned movie library.
    -Acceptance criteria:
      *User can sort owned movies

  * As a movie recommender
    In order to give advice based on movies I've seen
    I want to be able to view my ratings by genre.
    -Acceptance criteria:
      *User can sort by ratings
      *Include genre field from RT
      *User can sort genre field


## Feature 3: Rotten Tomatoes rating shown in for movies in tracker

  * As a researcher of opinions of movie critics and other movie goers
    In order to decide if a movie is one I want to see
    I want to be able to view Rotten Tomatoes critic and user ratings.
    -Acceptance criteria:
      *Include critic score field from RT for each movie
      *Include user score field from RT for each movie

  * As a movie critic
    In order to get a gauge of how I'm performing
    I want to be able to compare my movie rating skills to those of
    other rotten tomatoes critics and user ratings.
    -Acceptance criteria:
      *Show difference between user and RT ratings by movie
      *Show difference between user and RT ratings overall
      *Will not show differences for movies that have not been rated


