class Participant
  include MongoMapper::EmbeddedDocument

  key :score, Int

  many :player, :in => :players

end
