class Player
  include MongoMapper::Document

  key :first_name, String, :required => true
  key :nickname, String
  key :last_name, String, :required => true
  key :active, Boolean, default: true

  many :ranks

end
