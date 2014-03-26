class Rank
  include MongoMapper::EmbeddedDocument

  key :rank, Int

  belongs_to :player # This is where this model should be embedded, but...
  belongs_to :game_type # it needs to NOT be embedded in the game_type instances, though.

end
