#!/usr/bin/env ruby
# -*- ruby -*-

require_relative 'lib/environment'

require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

desc 'delete movie entries table'
task :prod_teardown do
  Environment.environment = "production"
  database = Environment.database_connection
  database.execute("drop table movie_entries")
end

desc 'import data from the given file'
task :import_data do
  Environment.environment = "production"
  require_relative 'lib/importer'
  Importer.import("data/movie_entries_import_sad.csv")
  # Importer.import("data/movie_entries_import_mid.csv")
  # Importer.import("data/movie_entries_import_good.csv")
end

desc 'create the production database setup'
task :bootstrap_database do
  Environment.environment = "production"
  database = Environment.database_connection
  create_tables(database)
end

desc 'prepare the test database'
task :test_prepare do
  File.delete("db/movie_test.sqlite3")
  Environment.environment = "test"
  database = Environment.database_connection
  create_tables(database)
end

def create_tables(database_connection)
  database_connection.execute("CREATE TABLE movie_entries (id INTEGER PRIMARY KEY AUTOINCREMENT, title varchar(100), seen boolean, own boolean, wishlist_see boolean, wishlist_own boolean, user_rating varchar(3), movie_id integer)")
  # database_connection.execute("CREATE TABLE movies (id INTEGER PRIMARY KEY AUTOINCREMENT, title varchar(100), year integer, rated varchar(10), runtime varchar(20), genre varchar(100), tomato_meter integer, tomato_image varchar(10), tomato_user_meter integer, released varchar(20), dvd varchar(20), production varchar(50), box_office varchar(10))")
end
