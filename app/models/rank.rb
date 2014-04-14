class Rank
  include MongoMapper::EmbeddedDocument

  key :game_type, ObjectId
  key :rank, Integer, default: 1000

end
