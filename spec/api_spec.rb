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

  after(:each) do
    [Bar, Verse, Song].each { clean(_1) }
  end

  def app
    Quick16::API
  end

  context 'GET /api/bars' do
    it 'returns a set of bars' do
      get '/api/bars'

      expect(last_response).to be_ok
      expect(last_response.body).to eq Bar.all.to_json
    end
  end

  context 'GET /api/bar/:id' do
    it 'returns the specified bar' do
      bar = Bar.create

      get "/api/bars/#{bar.id}"

      expect(last_response).to be_ok
      expect(last_response.body).to eq bar.to_json
    end
  end

  context 'PUT /api/bars/:id' do
    it 'updates the bar and returns it' do
      bar = Bar.create
      data = { text: 'this should be updated' }

      put "/api/bars/#{bar.id}", data

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)['text']).to eq 'this should be updated'
    end
  end

  context 'DELETE /api/bars/:id' do
    it 'deletes the bar' do
      bar = Bar.create

      delete "/api/bars/#{bar.id}"
      
      expect(last_response).to be_ok
      expect(Bar[bar.id]).to be nil
    end
  end

  context 'GET /api/verses' do
    it 'returns all verses' do
      get '/api/verses'

      expect(last_response).to be_ok
      expect(last_response.body).to eq Verse.all.to_json
    end
  end

  context 'GET /api/verses/:id' do
    it 'returns the specified verse' do
      verse = Verse.create

      get "/api/verses/#{verse.id}"

      expect(last_response).to be_ok
      expect(last_response.body).to eq verse.to_json
    end
  end

  context 'PUT /api/verses/:id' do
    it 'Updates the verse with the given bars' do
      bar = Bar.create
      verse = Verse.create

      data = {
        bars: [bar.id]
      }
      put "/api/verses/#{verse.id}", data

      expect(last_response).to be_ok
      expect(Verse[JSON.parse(last_response.body)['id']].bars).to include bar
    end
  end

  context 'DELETE /api/verses/:id' do
    it 'deletes the verse' do
      verse = Verse.create

      delete "/api/verses/#{verse.id}"
      
      expect(last_response).to be_ok
      expect(verse[verse.id]).to be nil
    end
  end

  context 'GET /api/songs' do
    it 'returns all songs' do
      get '/api/songs'

      expect(last_response).to be_ok
      expect(last_response.body).to eq Song.all.to_json
    end
  end

  context 'GET /api/songs/:id' do
    it 'returns the specified song' do
      song = Song.create

      get "/api/songs/#{song.id}"

      expect(last_response).to be_ok
      expect(last_response.body).to eq song.to_json
    end
  end

  context 'DELETE /api/songs/:id' do
    it 'deletes the song' do
      song = Song.create

      delete "/api/songs/#{song.id}"

      expect(last_response).to be_ok
      expect(song[song.id]).to be nil
    end
  end

  context 'PUT /api/songs/:id' do
    it 'Updates the song with the given verses' do
      song = Song.create
      verse = Verse.create
      data = {
        verses: [verse.id]
      }

      put "/api/songs/#{song.id}", data

      expect(last_response).to be_ok
      expect(Song[JSON.parse(last_response.body)['id']].verses).to include verse
    end
  end
end
