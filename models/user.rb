class User

  include DataMapper::Resource

  property :id,             Serial
  property :bgg_username,   String

  has n, :items
  has n, :games, through: :items

end
