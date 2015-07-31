
require_relative 'boot'
require_relative 'lib/bgg'

bgg_username = ENV['BGG_USERNAME'] || 'ma080239'

bgg = Bgg.new(debug: true)
collection = bgg.get_collection(bgg_username)

ids = collection.map { |x| x['objectid'] }

games = bgg.find(ids)

games.each do |game|
  name = [game['name']].flatten.first['value']
  Game.first_or_create({ bgg_id: game['id'] }, {
    image_url: game['image'],
    title: name,
    year_published: game['yearpublished'],
    expansion: (game['type'] == 'boardgameexpansion'),
    min_players: game['minplayers']['value'],
    max_players: game['maxplayers']['value'],
    duration: game['playingtime']['value'],
  })
end
