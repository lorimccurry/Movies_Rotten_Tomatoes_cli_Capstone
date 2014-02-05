class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.string :rated
      t.string :runtime
      t.string :genre
      t.integer :tomato_meter
      t.string :tomato_image
      t.integer :tomato_user_meter
      t.string :released
      t.string :dvd
      t.string :production
      t.string :box_office
    end
  end
end