require './lib/configuration'

module Configurations
  class Elasticsearch < Configuration
    def filename
      'elasticsearch.yml'
    end
  end
end
