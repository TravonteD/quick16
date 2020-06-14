require 'sequel'
require 'irb'
Sequel::Model.plugin :json_serializer
Sequel.connect('sqlite://db/q16.db')
require_relative '../api/quick16.rb'

def clean(obj)
  obj.each(&:delete)
end

RSpec.describe Quick16::API do
  include Rack::Test::Methods
   
  let(:bar) { Bar.create }
  let(:verse) { Verse.create }
  let(:song) { Song.create }
  after(:each) do
    [Bar, Verse, Song].each { clean(_1) }
  end

  def app
    Quick16::API
  end

  context 'GET /api/bars' do
    it 'returns a set of bars' do
      get '/api/bars'

      expect(last_response.ok?).to be true
      expect(last_response.body).to eq Bar.all.to_json
    end
  end

  context 'GET /api/bar/:id' do
    it 'returns the specified bar' do
      get "/api/bars/#{bar.id}"

      expect(last_response.ok?).to be true
      expect(last_response.body).to eq bar.to_json
    end
  end

  context 'PUT /api/bars/:id' do
    let(:data) { { text: 'this should be updated' } }

    it 'updates the bar and returns it' do
      put "/api/bars/#{bar.id}", data
      
      expect(last_response.ok?).to be true
      expect(JSON.parse(last_response.body, symbolize_names: true)[:text]).to eq 'this should be updated'
    end
  end

  context 'DELETE /api/bars/:id' do
    it 'deletes the bar' do
      delete "/api/bars/#{bar.id}"
      
      expect(last_response.ok?).to be true
      expect(Bar[bar.id]).to be nil
    end
  end

  context 'GET /api/verses' do
    it 'returns all verses' do
      get '/api/verses'

      expect(last_response.ok?).to be true
      expect(last_response.body).to eq Verse.all.to_json
    end
  end

  context 'GET /api/verses/:id' do
    it 'returns the specified verse' do
      get "/api/verses/#{verse.id}"

      expect(last_response.ok?).to be true
      expect(last_response.body).to eq verse.to_json
    end
  end

  context 'DELETE /api/verses/:id' do
    it 'deletes the verse' do
      delete "/api/verses/#{verse.id}"
      
      expect(last_response.ok?).to be true
      expect(verse[verse.id]).to be nil
    end
  end

  context 'GET /api/songs' do
    it 'returns all songs' do
      get '/api/songs'

      expect(last_response.ok?).to be true
      expect(last_response.body).to eq Song.all.to_json
    end
  end

  context 'GET /api/songs/:id' do
    it 'returns the specified song' do
      get "/api/songs/#{song.id}"

      expect(last_response.ok?).to be true
      expect(last_response.body).to eq song.to_json
    end
  end

  context 'DELETE /api/songs/:id' do
    it 'deletes the song' do
      delete "/api/songs/#{song.id}"
      
      expect(last_response.ok?).to be true
      expect(song[song.id]).to be nil
    end
  end
end
