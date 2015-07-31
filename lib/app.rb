class App < Sinatra::Base

  configure do
    set :server, :puma
    set :public_folder, File.expand_path('public')
  end

  get '/' do
    "Hello world"
  end

  get '/:username' do
    send_file File.expand_path('index.html', settings.public_folder)
  end

end
