class Rank
  include MongoMapper::EmbeddedDocument

  key :game_type, ObjectId
  key :rank, Integer, default: 1

end
