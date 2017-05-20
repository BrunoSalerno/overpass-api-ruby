require_relative 'base'

module OverpassAPI
  class XML < Base
    def build_query(q)
      bbox = @bbox ? "bbox='#{@bbox}'" : ''
      timeout = @timeout ? "timeout='#{@timeout}'" : ''
      maxsize = @maxsize ? "maxsize='#{@maxsize}'" : ''
      "<osm-script #{bbox} #{timeout} #{maxsize} output='json'>#{q}<print/></osm-script>"
    end
  end
end
