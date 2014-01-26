require_relative '../lib/environment'
require 'sqlite3'

class MovieEntry
  attr_accessor :title, :seen, :own, :wishlist_see, :wishlist_own, :rating

  def initialize attributes = {}
    attributes.each_pair do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  def to_s
    "#{title}: seen #{seen}, own #{own}, wishlist see #{wishlist_see}, wishlist own #{wishlist_own}, user rating: #{rating}"
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from cinephile_movies_test order by title ASC")
    results.map do |row_hash|
      MovieEntry.new(title: row_hash["title"], seen: row_hash["seen"], own: row_hash["own"], wishlist_see: row_hash["wishlist_see"], wishlist_own: row_hash["wishlist_own"], rating: row_hash["user_rating"])
    end
  end

  def self.add options
  end

  def self.search
  end

  def update
  end

  def delete
  end
end
