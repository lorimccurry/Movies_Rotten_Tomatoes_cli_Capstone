class Environment
  def self.database_connection(environment = "production")
    # memoization
    @connection ||= SQLite3::Database.new("db/movie_#{environment}.sqlite3")
  end
end