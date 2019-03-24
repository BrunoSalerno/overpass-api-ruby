require_relative 'base'

module OverpassAPI
  # builds queries in xml format
  class XML < Base
    def initialize(args = {})
      super
      @element_limit = args[:element_limit]
    end

    def build_query(query)
      bbox = @bbox ? " bbox='#{@bbox}'" : ''
      timeout = @timeout ? " timeout='#{@timeout}'" : ''
      element_limit = @element_limit ? " element-limit='#{@element_limit}'" : ''

      "<osm-script#{bbox}#{timeout}#{element_limit} output='json'>" \
      "#{query}<print/></osm-script>"
    end
  end
end
