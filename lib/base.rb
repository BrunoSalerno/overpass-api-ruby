require 'httpi'
require 'open-uri'
require 'json'

module OverpassAPI
  class Base
    DEFAULT_ENDPOINT='http://overpass-api.de/api/interpreter?data='

    def initialize(args={})
      bbox = args[:bbox]
      bounding_box(bbox[:s],bbox[:n],bbox[:w],bbox[:e]) if bbox

      @endpoint = args[:endpoint] || DEFAULT_ENDPOINT
      @timeout = args[:timeout]
      @maxsize = args[:maxsize]
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
      url = URI::encode("#{@endpoint}#{q}")
      r = HTTPI::Request.new(url)
      JSON.parse(HTTPI.get(r).body, symbolize_names: true)
    end
  end
end
