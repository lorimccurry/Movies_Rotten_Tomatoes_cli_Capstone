class CreateMovieEntries < ActiveRecord::Migration
  def change
    create_table :movie_entries do |t|
      t.string :title
      t.boolean :seen
      t.boolean :own
      t.boolean :wishlist_see
      t.boolean :wishlist_own
      t.string :user_rating
      t.belongs_to :movie
    end
  end
end