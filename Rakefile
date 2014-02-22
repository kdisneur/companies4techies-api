require 'elasticsearch'
require 'json'

DEFAULT_ES_VERSION = '0.90.10'

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
  elasticsearch = Elasticsearch::Client.new(host: ENV['ES_HOST'])
  elasticsearch.indices.delete(index: 'companies4techies') if elasticsearch.indices.exists(index: 'companies4techies')
  elasticsearch.indices.create({ index: 'companies4techies' }.merge(body: JSON.parse(IO.read('config/mapping.json'))))

  companies_data = Dir.glob('data/*.json').map do |company|
    { create: { index: { _index: 'companies4techies', _type: 'company', data: JSON.parse(IO.read(company)) }}}
  end

  elasticsearch.bulk body: companies_data
end

desc 'Load a company in Elasticsearch'
task :load_company, :company_name do |task, arguments|
  company_name  = arguments[:company_name]
  elasticsearch = Elasticsearch::Client.new(host: ENV['ES_HOST'])
  company_data  = { create: { index: { _index: 'companies4techies', _type: 'company', data: JSON.parse(IO.read("data/#{company_name}.json")) }}}

  elasticsearch.create index: 'companies4techies', type: 'company', body: company_data
end
