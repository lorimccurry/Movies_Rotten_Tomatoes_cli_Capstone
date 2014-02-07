class MovieEntries < ActiveRecord::Base
  belongs_to :movie
  # has_one :movie
  default_scope { order("title ASC") }
  before_create :set_default_movie

  def self.search(search_term = nil)
    MovieEntries.where("title LIKE ?", "%#{search_term}%").to_a
  end

  def to_s
    "#{title}: seen #{seen}, own #{own}, wishlist see #{wishlist_see}, wishlist own #{wishlist_own}, user rating: #{user_rating}, id: #{id}"
  end

  def self.compare_ratings(search_term = nil)
    # database = Environment.database_connection
    # database.results_as_hash = true
    # results = database.execute("select * from movie_entries where user_rating != 'none'")
    test = MovieEntries.select("movie_entries.title, movie_entries.user_rating, movie_entries.movie.tomato_meter").where.not(user_rating: 'none')
    puts test

    SELECT movies.title,
       movie_entries.user_rating, movies.tomato_meter,
      avg(abs(movies.tomato_meter - movie_entries.user_rating))
      FROM movie_entries
      join movies on movie_entries.movie_id = movies.id
      WHERE movie_entries.user_rating != 'none'

    # MovieEntries.find_each.select(title, user_rating, movie.tomato_meter) do |movie_entry|
    # end

    #.order("created_at ASC")

    #   movie_entry = MovieEntries.new(
    #                 title: row_hash["title"],
    #                 seen: row_hash["seen"],
    #                 own: row_hash["own"],
    #                 wishlist_see: row_hash["wishlist_see"],
    #                 wishlist_own: row_hash["wishlist_own"],
    #                 user_rating: row_hash["user_rating"])
    #   movie = Movie.all.find{|movie| movie.id == row_hash["movie_id"]}
    #   movie_entry.movie = movie
    #   movie_entry.send("id=", row_hash["id"])
    #   movie_entry
    # end
  end

  private

  def set_default_movie
    self.movie ||= Movie.default
  end
end
