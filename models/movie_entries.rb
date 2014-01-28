require_relative '../lib/environment'
require 'sqlite3'

class MovieEntries
  attr_accessor :title, :seen, :own, :wishlist_see, :wishlist_own, :user_rating
  attr_reader :id

  def initialize attributes = {}
    [:title, :seen, :own, :wishlist_see, :wishlist_own, :user_rating].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def self.create(attributes = {})
    movie_entry = MovieEntries.new(attributes)
    movie_entry.save
    movie_entry
  end

  def save
    database = Environment.database_connection
    database.execute("insert into movie_entries(title, seen, own, wishlist_see, wishlist_own, user_rating) values('#{title}', '#{seen}', '#{own}', '#{wishlist_see}', '#{wishlist_own}', '#{user_rating}')")
    @id = database.last_insert_row_id
    #fails silently
    #susceptible to SQL injection
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from movie_entries order by title ASC")
    results.map do |row_hash|
      movie_entry = MovieEntries.new(title: row_hash["title"], seen: row_hash["seen"], own: row_hash["own"], wishlist_see: row_hash["wishlist_see"], wishlist_own: row_hash["wishlist_own"], user_rating: row_hash["user_rating"])
      movie_entry.send("id=", row_hash["id"])
      movie_entry
    end
  end

  def to_s
    "#{title}: seen #{seen}, own #{own}, wishlist see #{wishlist_see}, wishlist own #{wishlist_own}, user rating: #{user_rating}, id: #{id}"
  end

  protected

  def id=(id)
    @id = id
  end
end
