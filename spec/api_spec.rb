require 'sequel'
require 'irb'
Sequel::Model.plugin :json_serializer
Sequel.connect('sqlite://db/q16.db')
require_relative '../api/quick16.rb'

RSpec.describe Quick16::API do
  include Rack::Test::Methods
   
  let(:bar) { Bar.create }
  after(:each) do
    Bar.each(&:delete)
  end

  def app
    Quick16::API
  end

  context 'GET /api/bars' do
    it 'returns a set of bars' do
      get '/api/bars'

      expect(last_response.status).to be 200
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
      
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body, symbolize_names: true)[:text]).to eq 'this should be updated'
    end
  end

  context 'DELETE /api/bars/:id' do
    it 'deletes the bar' do
      delete "/api/bars/#{bar.id}"
      
      expect(last_response.status).to eq 200
      expect(Bar[bar.id]).to be nil
    end
  end
end

