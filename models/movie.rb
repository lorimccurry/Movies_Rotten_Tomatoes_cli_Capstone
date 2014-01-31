require_relative '../lib/environment'
require 'sqlite3'
class Movie
  attr_accessor :title, :year, :rated, :runtime, :genre, :tomato_meter, :tomato_image, :tomato_user_meter, :released, :dvd, :production, :box_office
  attr_reader :id

  def initialize(title)
    self.title = title
  end

  def title=(title)
    @title = title.strip
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from movies order by title ASC")
    results.map do |row_hash|
      movie = Movie.new(row_hash["title"])
      movie.send("id=", row_hash["id"])
      movie
    end
  end

  def self.find_or_create title
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from movies where title = '#{title}'")
    movie = Movie.new(title)

    if results.empty?
      database.execute("insert into movies(title) values ('#{movie.title}')")
      movie.send("id=", database.last_insert_row_id)
    else
      row_hash = results[0]
      movie.send("id=", row_hash["id"])
    end
    movie
  end

  protected

  def id=(id)
    @id = id
  end
end
