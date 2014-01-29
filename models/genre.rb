class Genre
  attr_accessor :name
  attr_reader :id

  def intialize(attributes = {})
    @name = attributes[:name]
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from genre order by name ASC")
    results.map do |row_hash|
      genre = Genre.new(name: row_hash["name"])
      genre.send("id=", row_hash["id"])
      genre
    end
  end

  def self.create arguments
    genre = Genre.new(arguments)
    database = Environment.database_connection
    database.execute("insert into genre(name) values('#{genre.name}')")
    genre.send("id=", database.last_insert_row_id)
    genre
  end

  protected

  def id=(id)
    @id = id
  end
end