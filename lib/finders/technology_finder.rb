class TechnologyFinder
  attr_reader :elasticsearch

  def initialize(elasticsearch)
    @elasticsearch = elasticsearch
  end

  def find_by_technology(technology)
    elasticsearch.search({
      filtered: {
        query: {
          bool: {
            must: [
              { term: { technologies: technology }}
            ]
          }
        }
      }
    })
  end
end
