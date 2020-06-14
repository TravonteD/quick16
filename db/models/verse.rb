require 'sequel'

class Verse < Sequel::Model
  one_to_many :bars
  many_to_one :song

  def bars=(list)
    list.each { add_bar(_1) unless self.bars.include?(_1) }
    self.bars.reject { list.include?(_1) }.each { remove_bar(_1) }
  end
end
