class Player
  include MongoMapper::Document

  key :first_name, String
  key :nickname, String
  key :last_name, String

  many :ranks

end
