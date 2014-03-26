class GameType
  include MongoMapper::Document

  key :name, String

  many :rank

end
