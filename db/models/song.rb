require 'sequel'

class Song < Sequel::Model
  one_to_many :verses

  def verses=(list)
    list.each { add_verse(_1) unless self.verses.include?(_1) }
    self.verses.reject { list.include?(_1) }.each { remove_verse(_1) }
  end
end
