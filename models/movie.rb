require_relative '../lib/environment'
require 'sqlite3'
class Movie
  attr_accessor :title, :year, :rated, :runtime, :genre, :tomato_meter, :tomato_image, :tomato_user_meter, :released, :dvd, :production, :box_office
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def self.create(attributes = {})
    movie_entry = Movie.new(attributes)
    movie_entry.save
    movie_entry
  end

  def save
    database = Environment.database_connection
    if id
      database.execute("update movies set title = '#{title}', year = '#{year}', rated = '#{rated}', runtime = '#{runtime}', genre = '#{genre}', tomato_meter = '#{tomato_meter}',
    tomato_image = '#{tomato_image}', tomato_user_meter = '#{tomato_user_meter}', released = '#{released}', dvd = '#{dvd}',
    production = '#{production}', box_office = '#{box_office}' where id = '#{id}'")
    else
      database.execute("insert into movies(title, year, rated, runtime, genre, tomato_meter,
    tomato_image, tomato_user_meter, released, dvd, production, box_office)
      values('#{title}',
    '#{year}', '#{rated}', '#{runtime}', '#{genre}', '#{tomato_meter}',
    '#{tomato_image}', '#{tomato_user_meter}', '#{released}', '#{dvd}',
    '#{production}', '#{box_office}')")
      @id = database.last_insert_row_id
    end
    #fails silently
    #susceptible to SQL injection
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:title, :year, :rated, :runtime, :genre, :tomato_meter, :tomato_image, :tomato_user_meter, :released, :dvd, :production, :box_office].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end

end