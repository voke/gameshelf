require './lib/game_updater'

class GetMetadataWorker
  include Sidekiq::Worker

  def perform(id)
    game = Game.get(id)
    GameUpdater.update(game)
  end
end
