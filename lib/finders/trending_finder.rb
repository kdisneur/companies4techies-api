require './lib/finders/base'

module Finders
  class TrendingFinder < Base
    def find_trending
      search({ match_all: {}})
    end
  end
end
