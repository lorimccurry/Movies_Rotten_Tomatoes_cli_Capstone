class Movie < ActiveRecord::Base
  default_scope { order("title ASC") }

  def self.default
    Movie.find_or_create_by(title: "Unknown")
  end

end