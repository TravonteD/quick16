require 'sequel'
Sequel.connect('sqlite://db/q16.db')
require_relative '../../db/models/song'

RSpec.describe Song do
  it 'contains verses' do
    song = Song.new

    expect(song).to respond_to :verses
  end

  describe '#verses=' do
    it 'sets the songs verses to the list' do
      song = Song.create
      verse = Verse.create

      expect(song.verses).to be_empty

      song.verses = [verse]

      expect(song.verses).to include verse
    end
  end
end

