class Game
  include MongoMapper::Document

  key :game_type, ObjectId
  key :date, Time

  many :participants

end
