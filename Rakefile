require 'net/http'

DEFAULT_ES_VERSION = '0.90.10'

desc 'Create bin directories'
directory 'bin'

desc 'Create tmp directories'
directory 'tmp/pids'

desc 'Install Elasticsearch'
task install_elasticsearch: ['bin'] do
  es_version = ENV['ES_VERSION'] ? ENV['ES_VERSION'] : DEFAULT_ES_VERSION
  es_name    = "elasticsearch-#{es_version}"
  url        = "https://download.elasticsearch.org/elasticsearch/elasticsearch/#{es_name}.tar.gz"

  system("wget #{url} -O #{es_name}.tgz && tar zxf #{es_name}.tgz -C bin/. && ln -s #{Dir.pwd}/bin/#{es_name} bin/elasticsearch && rm #{es_name}.tgz")
end

desc 'Bootsrap the app'
task install: ['tmp/pids', :install_elasticsearch] do
end
