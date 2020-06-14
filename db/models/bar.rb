require 'sequel'

class Bar < Sequel::Model
  many_to_one :verse
end
