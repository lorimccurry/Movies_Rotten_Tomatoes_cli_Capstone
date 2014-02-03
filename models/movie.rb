# require_relative '../lib/environment'
# require 'sqlite3'
class Movie
  attr_accessor :title, :year, :rated, :runtime, :genre, :tomato_meter, :tomato_image, :tomato_user_meter, :released, :dvd, :production, :box_office
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def title=(title)
    @title = title.strip
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from movies order by title ASC")
    results.map do |row_hash|
      movie = Movie.new(title: row_hash["title"], year: row_hash["year"], rated: row_hash["rated"], runtime: row_hash["runtime"], genre: row_hash["genre"], tomato_meter: row_hash["tomato_meter"], tomato_image: row_hash["tomato_image"], tomato_user_meter: row_hash["tomato_user_meter"], released: row_hash["released"], dvd: row_hash["dvd"], production: row_hash["production"], box_office: row_hash["box_office"])
      movie.send("id=", row_hash["id"])
      movie
    end
  end

  def self.find_or_create attributes = {}
    database = Environment.database_connection
    database.results_as_hash = true
    movie = Movie.new(attributes)
    results = database.execute("select * from movies where title LIKE '%#{movie.title}%'")
    if results.empty?
      database.execute("insert into movies(title, year, rated, runtime, genre, tomato_meter,tomato_image, tomato_user_meter, released, dvd, production, box_office) values('#{attributes[:title]}', '#{attributes[:year]}', '#{attributes[:rated]}', '#{attributes[:runtime]}', '#{attributes[:genre]}', '#{attributes[:tomato_meter]}', '#{attributes[:tomato_image]}', '#{attributes[:tomato_user_meter]}', '#{attributes[:released]}', '#{attributes[:dvd]}', '#{attributes[:production]}', '#{attributes[:box_office]}')")
      movie.send("id=", database.last_insert_row_id)
    else
      row_hash = results[0]
      attr_hash = {title: row_hash["title"], year: row_hash["year"], rated: row_hash["rated"], runtime: row_hash["runtime"], genre: row_hash["genre"], tomato_meter: row_hash["tomato_meter"], tomato_image: row_hash["tomato_image"], tomato_user_meter: row_hash["tomato_user_meter"], released: row_hash["released"], dvd: row_hash["dvd"], production: row_hash["production"], box_office: row_hash["box_office"]}
      movie.send("update_attributes", attr_hash)
      movie.send("id=", row_hash["id"])
    end
    movie
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes (attributes)
    [:title, :year, :rated, :runtime, :genre, :tomato_meter, :tomato_image, :tomato_user_meter, :released, :dvd, :production, :box_office].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end
