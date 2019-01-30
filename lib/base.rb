require 'httpi'
require 'json'

module OverpassAPI
  class Base
    DEFAULT_ENDPOINT='http://overpass-api.de/api/interpreter'

    def initialize(args={})
      bbox = args[:bbox]
      bounding_box(bbox[:s],bbox[:n],bbox[:w],bbox[:e]) if bbox

      @endpoint = args[:endpoint] || DEFAULT_ENDPOINT
      @timeout = args[:timeout]
    end

    def bounding_box(s,n,w,e)
      @bbox = "#{s},#{w},#{n},#{e}"
    end

    def query(q)
      perform build_query(q)
    end

    def raw_query(q)
      perform q
    end

    private

    def perform(q)
      r = HTTPI::Request.new(url: @endpoint, body: q)
      JSON.parse(HTTPI.post(r).body, symbolize_names: true)
    end
  end
end
