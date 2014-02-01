#!/usr/bin/env ruby
# -*- ruby -*-

require_relative 'lib/environment'
require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

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
  database_connection.execute("CREATE TABLE movie_entries (id INTEGER PRIMARY KEY AUTOINCREMENT, title varchar(100), seen integer, own integer, wishlist_see integer, wishlist_own integer, user_rating varchar(3), movie_id integer)")
  database_connection.execute("CREATE TABLE movies (id INTEGER PRIMARY KEY AUTOINCREMENT, title varchar(100), year integer, rated varchar(10), runtime varchar(20), genre varchar(100), tomato_meter integer, tomato_image varchar(10), tomato_user_meter integer, released varchar(20), dvd varchar(20), production varchar(50), box_office varchar(10))")
end
