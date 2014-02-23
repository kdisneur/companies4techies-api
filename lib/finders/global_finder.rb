require './lib/finders/base'

module Finders
  class GlobalFinder < Base
    def fulltext(query)
      search(
        multi_match: {
          query:  query,
          fields: ['technologies^2', 'type', 'name']
        }
      )
    end
  end
end
