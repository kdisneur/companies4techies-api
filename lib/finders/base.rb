module Finders
  class Base
    attr_reader :elasticsearch

    def initialize(elasticsearch)
      @elasticsearch = elasticsearch
    end

    def search(body)
      elasticsearch.search(body)
    end
  end
end
