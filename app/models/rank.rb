class Rank
  include MongoMapper::EmbeddedDocument

  key :game_type, ObjectId
  key :rank, Integer

end
