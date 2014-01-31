require 'csv'

class Importer
  def self.import(from_filename)
    CSV.foreach(from_filename, headers: true) do |row_hash|
      import_movie_entry(row_hash)
    end
  end

  def self.import_movie_entry(row_hash)
    movie = Movie.find_or_create(row_hash["title"])
    movie_entry = MovieEntries.create(
      title: row_hash["title"],
      seen: row_hash["seen"],
      own: row_hash["own"],
      wishlist_see: row_hash["wishlist_see"],
      wishlist_own: row_hash["wishlist_own"],
      user_rating: row_hash["user_rating"].to_i
    )
  end

end