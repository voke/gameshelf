class API < Grape::API

  version 'v1'
  prefix :api
  format :json

  get :games do
    @games = Game.all
  end

end
