require 'csv'
class Importer
  def self.import(from_filename)
    CSV.foreach(from_filename, headers: true) do |row_hash|
      import_movie_entry(row_hash)
    end
  end

  def self.import_movie_entry(row_hash)
    movie = Movie.find_or_create_by(
      title: row_hash["title"], year: row_hash["year"], rated: row_hash["rated"], runtime:row_hash["runtime"], genre: row_hash["genre"], tomato_meter: row_hash["tomato_meter"], tomato_image: row_hash["tomato_image"], tomato_user_meter: row_hash["tomato_user_meter"], released: row_hash["released"], dvd: row_hash["dvd"], production: row_hash["production"], box_office: row_hash["box_office"]
      )
    movie_entry = MovieEntries.create(
      title: row_hash["title"],
      seen: row_hash["seen"],
      own: row_hash["own"],
      wishlist_see: row_hash["wishlist_see"],
      wishlist_own: row_hash["wishlist_own"],
      user_rating: row_hash["user_rating"],
      movie: movie
    )
  end

  def self.import_movies
    movie = Movie.find_or_create_by(
      title: row_hash["title"], year: row_hash["year"], rated: row_hash["rated"], runtime:row_hash["runtime"], genre: row_hash["genre"], tomato_meter: row_hash["tomato_meter"], tomato_image: row_hash["tomato_image"], tomato_user_meter: row_hash["tomato_user_meter"], released: row_hash["released"], dvd: row_hash["dvd"], production: row_hash["production"], box_office: row_hash["box_office"]
      )
  end

end