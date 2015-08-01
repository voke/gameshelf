require_relative 'bgg'

class GameUpdater

  def initialize(game)
    @game = game
    @bgg = Bgg.new(debug: true)
  end

  def self.update(game)
    new(game).update
  end

  def update
    metadata = @bgg.find(@game.bgg_id)
    @game.update(
      image_url: metadata['image'],
      year_published: metadata['yearpublished']['value'],
      expansion: (metadata['type'] == 'boardgameexpansion'),
      min_players: metadata['minplayers']['value'],
      max_players: metadata['maxplayers']['value'],
      duration: metadata['playingtime']['value']
    )
  end
  
end
