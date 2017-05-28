require_relative 'base'

module OverpassAPI
  class XML < Base
    def initialize(args={})
      super

      @element_limit = args[:element_limit]
    end

    def build_query(q)
      bbox = @bbox ? "bbox='#{@bbox}'" : ''
      timeout = @timeout ? "timeout='#{@timeout}'" : ''
      element_limit = @element_limit ? "element-limit='#{@element_limit}'" : ''
      "<osm-script #{bbox} #{timeout} #{element_limit} output='json'>#{q}<print/></osm-script>"
    end
  end
end
