class Item

  include DataMapper::Resource

  property :id, Serial

  belongs_to :user, key: true
  belongs_to :game, key: true

end
