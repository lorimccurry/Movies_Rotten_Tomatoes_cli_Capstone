class MovieEntries < ActiveRecord::Base
  belongs_to :movie
  default_scope { order("title ASC") }
  before_create :set_default_movie

  def self.search(search_term = nil)
    MovieEntries.where("title LIKE ?", "%#{search_term}%").to_a
  end

  def to_s
    "#{title}: seen #{seen}, own #{own}, wishlist see #{wishlist_see}, wishlist own #{wishlist_own}, user rating: #{user_rating}, id: #{id}"
  end

  private

  def set_default_movie
    self.movie ||= Movie.default
  end
end
