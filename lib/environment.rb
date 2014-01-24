require_relative 'database'
require 'logger'

class Environment
  def self.database_connection(environment = "production")
    Database.connection(@@environment)
  end

  def self.environment= environment
    @@environment = environment
  end

  def self.logger
    @@logger ||= Logger.new("logs/#{@@environment}.log")
  end

end