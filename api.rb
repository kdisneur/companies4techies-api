require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sinatra/dependency_injection'
require 'sinatra/json'
require 'sinatra/reloader' if development?

class API < Sinatra::Base
  register Sinatra::Reloader
  register Sinatra::DependencyInjection

  dependency_injection_path 'config/services.yml'

  get '/technology/:technology' do
    json container.get('technology_finder').find_by_technology(params[:technology])
  end

  get '/technology/:technology/in/:country/:city' do
    json container.get('technology_finder').find_by_technology_and_location(params[:technology], params[:country], params[:city])
  end

  get '/trending' do
    json container.get('trending_finder').find_trending
  end

  get '/search' do
    json container.get('global_finder').fulltext(params[:q])
  end
end
