require_relative 'base'

module OverpassAPI
  # builds queries in overpass ql format
  class QL < Base
    def initialize(args = {})
      super
      @maxsize = args[:maxsize]
    end

    def build_query(query)
      header = ''
      header << "[bbox:#{@bbox}]" if @bbox
      header << "[timeout:#{@timeout}]" if @timeout
      header << "[maxsize:#{@maxsize}]" if @maxsize

      header << '[out:json]'

      "#{header};#{query}"
    end
  end
end
