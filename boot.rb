require 'bundler'
Bundler.require

DataMapper::Logger.new($stdout, :debug)

dev_db_path = File.expand_path(File.join(File.dirname(__FILE__), 'development.sqlite3'))
database_url = ENV['DATABASE_URL'] || "sqlite3://#{dev_db_path}"

DataMapper.setup(:default, database_url)
Dir['models/*'].each { |file| require_relative file }

DataMapper.finalize
DataMapper.auto_upgrade!
