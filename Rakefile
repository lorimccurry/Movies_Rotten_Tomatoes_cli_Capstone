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
  database = Environment.database_connection("production")
  create_tables(database)
end

desc 'prepare the test database'
task :test_prepare do
  File.delete("db/movie_test.sqlite3")
  database = Environment.database_connection("test")
  create_tables(database)
end

def create_tables(database_connection)
  database_connection.execute("CREATE TABLE cinephile_movies_test (id INTEGER PRIMARY KEY AUTOINCREMENT, title varchar(100), seen integer, own integer, wishlist_see integer, wishlist_own integer, user_rating integer)")
end
