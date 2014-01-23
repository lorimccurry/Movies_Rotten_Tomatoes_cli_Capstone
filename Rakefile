#!/usr/bin/env ruby
# -*- ruby -*-

require_relative 'lib/environment'
require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

task :bootstrap_database do
  require 'sqlite3'
  database = Environment.database_connection("production")
  database.execute("CREATE TABLE cinephile_movies_test (id INTEGER PRIMARY KEY AUTOINCREMENT, title varchar(100), seen integer, own integer, wishlist_see integer, wishlist_own integer, user_rating integer)")
end

task :test_prepare do
  require 'sqlite3'
  File.delete("db/movie_test.sqlite3")
  database = Environment.database_connection("test")
  database.execute("CREATE TABLE cinephile_movies_test (id INTEGER PRIMARY KEY AUTOINCREMENT, title varchar(100), seen integer, own integer, wishlist_see integer, wishlist_own integer, user_rating integer)")
end

