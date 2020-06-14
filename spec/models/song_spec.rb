require 'sequel'
Sequel.connect('sqlite://db/q16.db')
require_relative '../../db/models/song'

RSpec.describe Song do
  it 'contains verses' do
    song = Song.new

    expect(song).to respond_to :verses
  end
end

