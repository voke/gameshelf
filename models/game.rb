require_relative '../workers/get_metadata_worker'

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

  has n, :items
  has n, :users, through: :items

  # TODO: Find a way to skip callback
  after :create, :enqueue_get_metadata

  def metadata?
    ![title, min_players, max_players, duration, year_published, image_url].any?(&:blank?)
  end

  def enqueue_get_metadata
    GetMetadataWorker.perform_async(self.id)
  end

end
