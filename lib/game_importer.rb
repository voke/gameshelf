require_relative 'bgg'

class GameImporter

  def initialize(user)
    @user = user
    @bgg = Bgg.new(debug: true)
  end

  def self.import(user)
    new(user).import
  end

  def import
    collection = @bgg.get_collection(@user.bgg_username)
    collection.each do |obj|
      game = Game.first_or_create({ bgg_id: obj['objectid'] }, {
          title: obj['name']
        })
      @user.items.create(game: game)
    end
  end

end
