# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "movie_entries", force: true do |t|
    t.string  "title",        limit: 100
    t.boolean "seen"
    t.boolean "own"
    t.boolean "wishlist_see"
    t.boolean "wishlist_own"
    t.string  "user_rating",  limit: 3
    t.integer "movie_id"
  end

  create_table "movies", force: true do |t|
    t.string  "title",             limit: 100
    t.integer "year"
    t.string  "rated",             limit: 10
    t.string  "runtime",           limit: 20
    t.string  "genre",             limit: 100
    t.integer "tomato_meter"
    t.string  "tomato_image",      limit: 10
    t.integer "tomato_user_meter"
    t.string  "released",          limit: 20
    t.string  "dvd",               limit: 20
    t.string  "production",        limit: 50
    t.string  "box_office",        limit: 10
  end

end
