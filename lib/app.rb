class App < Sinatra::Base

  configure do
    set :server, :puma
  end

  get '/' do
    send_file File.expand_path('index.html', settings.public_folder)
  end

end
