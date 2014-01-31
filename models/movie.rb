require_relative '../lib/environment'
require 'sqlite3'
class Movie
  attr_accessor :title, :year, :rated, :runtime, :genre, :tomato_meter, :tomato_image, :tomato_user_meter, :released, :dvd, :production, :box_office
  attr_reader :id

  def initialize(attributes = {})
    @title = attributes[:title]
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from movies order by title ASC")
    results.map do |row_hash|
      movie = Movie.new(title: row_hash["title"])
      movie.send("id=", row_hash["id"])
      movie
    end
  end

  def self.create arguments
    movie = Movie.new(arguments)
    database = Environment.database_connection
    database.execute("insert into movies(title) values('#{movie.title}')")
    movie.send("id=", database.last_insert_row_id)
    movie
  end

  protected

  def id=(id)
    @id = id
  end
end
