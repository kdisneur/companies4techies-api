require './lib/finders/base'

module Finders
  class TechnologyFinder < Base
    def find_by_technology(technology)
      search(find_by_technology_to_json(technology))
    end

    def find_by_technology_and_location(technology, country, city)
      search(
        filtered: find_by_technology_to_json(technology).merge(find_by_location_to_json(country, city))
      )
    end

    private

    def find_by_location_to_json(country, city)
      {
        filter: {
          nested: {
            path: 'locations',
            query: {
              bool: {
                must: [
                  { term: { 'locations.country' => country }},
                  { term: { 'locations.city'    => city }}
                ]
              }
            }
          }
        }
      }
    end

    def find_by_technology_to_json(technology)
      {
        query: {
          bool: {
            must: [
              { term: { technologies: technology }}
            ]
          }
        }
      }
    end
  end
end
