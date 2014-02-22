require 'sinatra'

class API < Sinatra::Base
  get '/hi' do
    'YO'
  end
end
