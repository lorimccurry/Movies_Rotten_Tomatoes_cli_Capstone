require_relative '../lib/environment'

class MovieEntry
  def self.add options
    require "sqlite3"
    database = Environment.database_connection(options[:environment])
    # This is ripe for SQL injection attack:
    statement = "insert into cinephile_movies_test(title, seen, own, wishlist_see, wishlist_own, user_rating) values('#{options[:title]}', '#{options[:seen]}', '#{options[:own]}', '#{options[:wishlist_see]}', '#{options[:wishlist_own]}', '#{options[:rating]}')"
    database.execute(statement)
    puts "A movie named #{options[:title]}, with seen? #{options[:seen]}, own? #{options[:own]}, wishlist see #{options[:wishlist_see]}, wishlist own #{options[:wishlist_own]}, rating #{options[:rating]}"
  end

  def self.search
    puts "What do you want to search for?"
    input = $stdin.gets
    puts "You asked for: #{input}"
    # searching!
  end

  def update
  end

  def delete
  end

  def self.all
  end

  def to_s
  end
end
