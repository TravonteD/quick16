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
  end
end
