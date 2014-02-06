# require_relative '../lib/environment'
# require 'sqlite3'


class MovieEntries
  attr_accessor :title, :seen, :own, :wishlist_see, :wishlist_own, :user_rating, :movie
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def user_rating=(user_rating)
    @user_rating = user_rating
  end

  def self.count
    database = Environment.database_connection
    database.execute("select count(id) from movie_entries")[0][0]
  end

  def self.create(attributes = {})
    movie_entry = MovieEntries.new(attributes)
    movie_entry.save
    movie_entry
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  def save
    database = Environment.database_connection
    movie_id = movie.nil? ? "NULL" : movie.id
    if id
      database.execute("update movie_entries set title = '#{title}', seen = #{@seen}, own = #{@own}, wishlist_see = #{@wishlist_see}, wishlist_own = #{@wishlist_own}, user_rating = '#{user_rating}', movie_id = #{movie_id} where id = #{id}")
    else
      database.execute("insert into movie_entries(title, seen, own, wishlist_see, wishlist_own, user_rating, movie_id) values('#{title}', #{@seen}, #{@own}, #{@wishlist_see}, #{@wishlist_own}, '#{user_rating}', #{movie_id})")
      @id = database.last_insert_row_id
    end
    #fails silently
    #susceptible to SQL injection
  end

  def self.find id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from movie_entries where id = #{id}")[0]
    if results
      movie_entry = MovieEntries.new(title: results["title"], seen: results["seen"], own: results["own"], wishlist_see: results["wishlist_see"], wishlist_own: results["wishlist_own"], user_rating: results["user_rating"])
      movie_entry.send("id=", results["id"])
      movie_entry
    else
      nil
    end
  end

  def self.search(search_term = nil)
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select movie_entries.* from movie_entries where title LIKE '%#{search_term}%' order by title ASC")
    results.map do |row_hash|
      movie_entry = MovieEntries.new(
                    title: row_hash["title"],
                    seen: row_hash["seen"],
                    own: row_hash["own"],
                    wishlist_see: row_hash["wishlist_see"],
                    wishlist_own: row_hash["wishlist_own"],
                    user_rating: row_hash["user_rating"])
      movie = Movie.all.find{|movie| movie.id == row_hash["movie_id"]}
      movie_entry.movie = movie
      movie_entry.send("id=", row_hash["id"])
      movie_entry
    end
  end

  def self.all
    search
  end

  def self.compare_ratings(search_term = nil)
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from movie_entries where user_rating != 'none'")
    results.map do |row_hash|
      movie_entry = MovieEntries.new(
                    title: row_hash["title"],
                    seen: row_hash["seen"],
                    own: row_hash["own"],
                    wishlist_see: row_hash["wishlist_see"],
                    wishlist_own: row_hash["wishlist_own"],
                    user_rating: row_hash["user_rating"])
      movie = Movie.all.find{|movie| movie.id == row_hash["movie_id"]}
      movie_entry.movie = movie
      movie_entry.send("id=", row_hash["id"])
      movie_entry
    end
  end

  def delete attribute
    database = Environment.database_connection
    database.execute("delete from movie_entries where id = #{id}")
  end

  def to_s
    "#{title}: seen #{seen}, own #{own}, wishlist see #{wishlist_see}, wishlist own #{wishlist_own}, user rating: #{user_rating}, id: #{id}"
  end

  def seen
    @seen == 1
  end

  def own
    @own == 1
  end

  def wishlist_see
    @wishlist_see == 1
  end

  def wishlist_own
    @wishlist_own == 1
  end

  def ==(other)
    other.is_a?(MovieEntries) && self.to_s == other.to_s
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:title, :seen, :own, :wishlist_see, :wishlist_own, :user_rating, :movie].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end
