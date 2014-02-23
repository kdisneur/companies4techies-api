require 'dotenv'
Dotenv.load

require 'dependency_injection/container'
require 'dependency_injection/loaders/yaml'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader' if development?

$container = DependencyInjection::Container.new
loader     = DependencyInjection::Loaders::Yaml.new($container)
loader.load('config/services.yml')

class API < Sinatra::Base
  get '/technology/:technology' do
    json $container.get('technology_finder').find_by_technology(params[:technology])
  end

  get '/technology/:technology/in/:country/:city' do
    json $container.get('technology_finder').find_by_technology_and_location(params[:technology], params[:country], params[:city])
  end

  get '/trending' do
    json $container.get('trending_finder').find_trending
  end

  get '/search' do
    json $container.get('global_finder').fulltext(params[:q])
  end
end
