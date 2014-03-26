class Game
  include MongoMapper::Document

  key :date, Time

  belongs_to :game_type
  many :participant

end
