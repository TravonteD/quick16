require 'sequel'

class Verse < Sequel::Model
  one_to_many :bars
  many_to_one :song
end
