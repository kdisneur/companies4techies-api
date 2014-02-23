require 'elasticsearch'

class ElasticsearchClient < Elasticsearch::Transport::Client
  attr_reader :configuration

  def initialize(configuration)
    @configuration = configuration
    super(hosts: configuration.hosts, trace: configuration.trace)
  end

  def search(body)
    super(
      index: configuration.index,
      type:  configuration.type,
      body:  { query: body }
    )
  end
end
