require 'grape'
require_relative '../db/models/bar'

module Quick16
  class API < Grape::API
    prefix :api
    format :json

    resource :bars do
      desc 'Return a set of bars'
      get do
        Bar.all
      end

      desc 'Return the specified bar'
      params do
        requires :id, type: Integer, desc: 'Bar ID'
      end
      get ':id' do
        Bar[params[:id]]
      end

      desc 'Updates the fields of a bar'
      params do
        requires :id, type: Integer, desc: 'Bar ID'
        requires :text, type: String, desc: 'Bar text'
      end
      put ':id' do
        Bar[params[:id]].update(text: params[:text])
      end

      desc 'deletes a bar'
      params do
        requires :id, type: Integer, desc: 'Bar ID'
      end
      delete ':id' do
        Bar[params[:id]].delete
      end
    end

    resource :verses do
      desc 'Return a set of verses'
      get do
        Verse.all
      end

      desc 'Return the specified verse'
      params do
        requires :id, type: Integer, desc: 'Verse ID'
      end
      get ':id' do
        Verse[params[:id]]
      end

      desc 'Updates the verse with the given bars'
      params do
        requires :id, type: Integer, desc: 'Verse ID'
        requires :bars, type: Array, desc: 'list of Bar ID'
      end
      put ':id' do
        verse = Verse[params[:id]]
        verse.bars = params[:bars].map { Bar[_1] }
        verse
      end

      desc 'deletes a verse'
      params do
        requires :id, type: Integer, desc: 'Verse ID'
      end
      delete ':id' do
        Verse[params[:id]].delete
      end
    end

    resource :songs do
      desc 'Return a set of bars'
      get do
        Song.all
      end

      desc 'Return the specified bar'
      params do
        requires :id, type: Integer, desc: 'Bar ID'
      end
      get ':id' do
        Song[params[:id]]
      end

      desc 'Updates the verse with the given bars'
      params do
        requires :id, type: Integer, desc: 'Song ID'
        requires :verses, type: Array, desc: 'list of Verse ID'
      end
      put ':id' do
        song = Song[params[:id]]
        song.verses = params[:verses].map { Verse[_1] }
        song
      end

      desc 'deletes a song'
      params do
        requires :id, type: Integer, desc: 'Song ID'
      end
      delete ':id' do
        Song[params[:id]].delete
      end
    end
  end
end
