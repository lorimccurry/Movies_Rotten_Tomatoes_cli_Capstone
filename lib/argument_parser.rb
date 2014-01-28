require 'optparse'

class ArgumentParser
  def self.parse
    options = {environment: "production"}
    OptionParser.new do |opts|
      opts.banner = "Usage: movie [command] [options]"

      opts.on("--id [ID]", "The movie entry id") do |id|
        options[:id] = id
      end
      opts.on("-t [TITLE]", "The movie title") do |title|
        options[:title] = title
      end
      opts.on("-s [SEEN]", "Movie seen?") do |seen|
        options[:seen] = seen
      end
      opts.on("-o [OWN]", "Movie owned?") do |own|
        options[:own] = own
      end
      opts.on("--ws [WISHLIST_SEE]", "Wishlist see?") do |wishlist_see|
        options[:wishlist_see] = wishlist_see
      end
      opts.on("--wo [WISHLIST_OWN]", "Wishlist own?") do |wishlist_own|
        options[:wishlist_own] = wishlist_own
      end
      opts.on("-r [USER_RATING]", "The Rating") do |rating|
        options[:user_rating] = rating
      end
      opts.on("--environment [ENV]", "The database environment") do |env|
        options[:environment] = env
      end
    end.parse!
    options[:title] ||= ARGV[1]
    options[:command] = ARGV[0]
    options
  end

  def self.validate options
    errors = []
    if options[:title].nil? or options[:title].empty?
      errors << "You must provide the movie title you are adding\n"
    end

    missing_things = []
    missing_things << "seen?" unless options[:seen]
    missing_things << "own?" unless options[:own]
    missing_things << "wishlist see" unless options[:wishlist_see]
    missing_things << "wishlist own" unless options[:wishlist_own]
    missing_things << "user rating" unless options[:user_rating]
    unless missing_things.empty?
      errors << "You must provide the #{missing_things.join(" and ")} of the movie you are adding"
    end
    errors
  end
end