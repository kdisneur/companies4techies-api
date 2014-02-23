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
end
