require 'bundler'
Bundler.require

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite::memory:')

require_relative 'api'

class Web < Sinatra::Base

  configure do
    set :server, :puma
  end

  get '/' do
    send_file File.expand_path('index.html', settings.public_folder)
  end

end
