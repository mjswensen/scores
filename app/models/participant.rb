class Participant
  include MongoMapper::EmbeddedDocument

  key :score, Integer
  key :players, Set

end
