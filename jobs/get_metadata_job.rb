class GetMetadataJob
  include SuckerPunch::Job

  def perform(id)
    game = Game.get(id)
    game.update(duration: 1337)
  end
end
