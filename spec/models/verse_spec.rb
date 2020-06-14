require 'sequel'
Sequel.connect('sqlite://db/q16.db')
require_relative '../../db/models/verse.rb'

RSpec.describe Verse do
  it 'contains bars' do
    verse = Verse.create

    expect(verse).to respond_to :bars
  end

  it 'can have a song' do
    verse = Verse.create

    expect(verse).to respond_to :song
  end
end
