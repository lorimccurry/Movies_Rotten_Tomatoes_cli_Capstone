require 'csv'

class Importer

  def self.import(from_filename)
    CSV.foreach(from_filename, headers: true) do |row_hash|
      import_product(row_hash)
      Movie.create(row_hash["title"])
    end
  end

  def self.import_product(row_hash)
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