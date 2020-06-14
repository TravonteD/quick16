require 'sequel'
Sequel.connect('sqlite://db/q16.db')
require_relative '../../db/models/bar'

RSpec.describe Bar do
  it 'has a text field' do
    bar = Bar.new
    expect(bar).to respond_to :text
  end

  it 'can have a verse' do
    bar = Bar.new
    expect(bar).to respond_to :verse
  end
end
