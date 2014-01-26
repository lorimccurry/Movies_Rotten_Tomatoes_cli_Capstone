require_relative '../lib/environment'
require 'sqlite3'

class MovieEntry
  attr_accessor :title, :seen, :own, :wishlist_see, :wishlist_own, :rating

  def initialize attributes = {}
    attributes.each_pair do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  def to_s
    "#{title}: seen #{seen}, own #{own}, wishlist see #{wishlist_see}, wishlist own #{wishlist_own}, rating: #{rating}"
  end

  def self.add options
  end

  def self.search
  end

  def update
  end

  def delete
  end

  def self.all
  end
end
