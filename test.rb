p ARGV
p "> " + gets
p "> " + gets


"tolower(name) like '%#{movie.downcase}%'"





action = case ARGV[0]
         when "add_movie" then :add_movie
         end

add_movie(movie, genera, {
  matches: ->{|list|
    puts list
    puts "enter match"
    return gets
  }
})
#add_movie.rb
def add_movie(movie, genera, options)
   movies = Movie.matches_by_name(movie)
   if movies.size > 1
     match = options[:matches].call(movies)
   if movie.nil?
    Movie.create(movie, genera)
   end
end


#models/movie.rb


#example for irb
def add_movie(options)
  puts options[:test].call("first")
  puts options[:test].call("third")
end
add_movie(test: ->(input){
  puts input;
  return "second"
})

js


a = function(message) { console.log(message) }


a("test")
> "test"

b = function(takes_method) { takes_method("fake message") }

b(a)

> "fake message"
