require 'sequel'

class Song < Sequel::Model
  one_to_many :verses
end
