require "faraday"
require "csv"
require "json"
require "sqlite3"
require_relative "./lib/environment"
require_relative "./lib/argument_parser"
require_relative "./models/movie_entries"
require_relative "./models/movie"
require_relative "./lib/database"

Environment.environment = "production"
database = Environment.database_connection

csv_arrays = CSV.read("movie_lists/movie_list.csv")
csv_arrays.each do |arr|
  arr.delete(nil)
end
movie_titles = csv_arrays.flatten
jsons = []
movie_titles.each do |title|
  response = Faraday.get("http://www.omdbapi.com//?t=#{title}&tomatoes=true")
  jsons << response.body
end
jsons.each do |js|
  hash = JSON.parse(js)
  Movie.create(title: hash["Title"], year: hash["Year"], rated: hash["Rated"],
    runtime: hash["Runtime"], genre: hash["Genre"], tomato_meter: hash["tomatoMeter"],
    tomato_image: hash["tomatoImage"], tomato_user_meter: hash["tomatoUserMeter"], released: hash["Released"],
    dvd: hash["DVD"], production: hash["Production"], box_office: hash["BoxOffice"])
  # database.execute('insert into movies(title, year, rated, runtime, genre, tomato_meter,
  #   tomato_image, tomato_user_meter, released, dvd, production, box_office) values("#{hash["Title"]}",
  #   "#{hash["Year"]}", "#{hash["Rated"]}", "#{hash["Runtime"]}", "#{hash["Genre"]}", "#{hash["tomatoMeter"]}",
  #   "#{hash["tomatoImage"]}", "#{hash["tomatoUserMeter"]}", "#{hash["Released"]}", "#{hash["DVD"]}",
  #   "#{hash["Production"]}", "#{hash["BoxOffice"]}")')
end

# Title
# Year
# Rated
# Runtime
# Genre
# tomatoMeter
# tomatoImage
# tomatoUserMeter
# Released
# DVD
# Production
# BoxOffice
