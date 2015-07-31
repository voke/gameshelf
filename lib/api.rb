require_relative 'bgg'
require_relative 'game_importer'

class API < Grape::API

  version 'v1'
  prefix :api
  format :json

  get :games do
    unless user = User.first(bgg_username: params[:username])
      user = User.create(bgg_username: params[:username])
      GameImporter.import(user)
    end
    user.games
  end

end
