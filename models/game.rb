class Game
  include DataMapper::Resource

  property :id,             Serial
  property :title,          String
  property :bgg_id,         Integer
  property :min_players,    Integer
  property :max_players,    Integer
  property :duration,       Integer
  property :year_published, Integer
  property :expansion,      Boolean
  property :image_url,      String
end
