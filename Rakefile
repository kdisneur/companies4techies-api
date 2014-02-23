require 'dotenv'
Dotenv.load

require 'elasticsearch'
require 'json'
require './lib/configurations/elasticsearch'

DEFAULT_ES_VERSION = '1.0.0'

desc 'Create bin directories'
directory 'bin'

desc 'Create tmp directories'
directory 'tmp/pids'

desc 'Initialize data submodule'
task :initialize_data_submodule do
  system('git submodule init')
  system('git submodule update')
end

desc 'Install Elasticsearch'
task install_elasticsearch: ['bin'] do
  es_version = ENV['ES_VERSION'] ? ENV['ES_VERSION'] : DEFAULT_ES_VERSION
  es_name    = "elasticsearch-#{es_version}"
  url        = "https://download.elasticsearch.org/elasticsearch/elasticsearch/#{es_name}.tar.gz"

  system("wget #{url} -O #{es_name}.tgz && tar zxf #{es_name}.tgz -C bin/. && ln -s #{Dir.pwd}/bin/#{es_name} bin/elasticsearch && rm #{es_name}.tgz")
end

desc 'Bootstrap the app'
task install: ['tmp/pids', :initialize_data_submodule, :install_elasticsearch] do
end

desc 'Load companies in Elasticsearch'
task :load_companies do
  configuration = Configurations::Elasticsearch.new(ENV['RACK_ENV'])
  elasticsearch = Elasticsearch::Client.new(host: configuration.host)
  elasticsearch.indices.delete(index: configuration.index) if elasticsearch.indices.exists(index: configuration.index)
  elasticsearch.indices.create({ index: configuration.index }.merge(body: JSON.parse(IO.read('config/mapping.json'))))

  companies_data = Dir.glob('data/*.json').map do |company|
    { create: { _index: configuration.index, _type: configuration.type, data: JSON.parse(IO.read(company)) }}
  end

  elasticsearch.bulk body: companies_data
end

desc 'Load a company in Elasticsearch'
task :load_company, :company_name do |task, arguments|
  configuration = Configurations::Elasticsearch.new(ENV['RACK_ENV'])
  company_name  = arguments[:company_name]
  elasticsearch = Elasticsearch::Client.new(host: configuration.host)
  company_data  = { create: { _index: configuration.index, _type: configuration.type, data: JSON.parse(IO.read("data/#{company_name}.json")) }}

  elasticsearch.create index: configuration.index, type: configuration.type, body: company_data
end
