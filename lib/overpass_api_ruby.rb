require 'httpi'
require 'diskcached'
require 'open-uri'
require 'json'
require 'nokogiri'

class OverpassAPI
  VERSION='0.1.3'
  DEFAULT_ENDPOINT='http://overpass-api.de/api/interpreter?data='

  def initialize(args={})
    bbox = args[:bbox]
    bbox(bbox[:s],bbox[:n],bbox[:w],bbox[:e]) if bbox

    cache_expiration_time = args[:cache_expiration_time] || 7200
    @cache = Diskcached.new('/tmp/cache',cache_expiration_time,true)

    @endpoint = args[:endpoint] || DEFAULT_ENDPOINT
    @json = args[:json] ? "output='json'" : ''
    @timeout = args[:timeout] ? "timeout='#{args[:timeout]}'" : ''
    @element_limit = args[:element_limit] ? "element-limit='#{args[:element_limit]}'" : ''
    @dont_use_cache = args[:dont_use_cache]
  end

  def bbox(s,n,w,e)
    @bbox = "bbox='#{s},#{w},#{n},#{e}'"
  end

  def query(query)
    return unless query
    perform "<osm-script #{@bbox} #{@timeout} #{@element_limit} #{@json}>" <<
            "#{query}<print/></osm-script>"
  end

  def raw_query(query)
    return unless query
    perform query
  end

  private
  def request(url)
    r = HTTPI::Request.new(url)
    HTTPI.get(r).body
  end

  def perform(query)
    url = URI::encode("#{@endpoint}#{query}")
    data = if @dont_use_cache
                request url
           else
                @cache.cache("overpass_api_ruby_#{query}") do
                    request url
                end
           end          

    return JSON.parse(data, :symbolize_names=> true)[:elements] unless @json.empty?

    doc = Nokogiri::XML(data) do |config|
      config.options = Nokogiri::XML::ParseOptions::NOBLANKS
    end

    raw = doc.children.first.children.select{|e| e.name != 'note' and e.name != 'meta'}
    parse_nokogiri raw
  end

  def parse_nokogiri(xml)
    xml.map {|e|
      element = {:type => e.name}

      e.attributes.each {|a|
        element[a[1].name.to_sym] = a[1].value
      }

      members = e.children.select{|n| n.name != 'tag'}.map {|child|
        key_values={:type => child.name }
        child.attributes.each {|a|
          key_values[a[1].name.to_sym] = a[1].value
        }
        key_values
      }
      element[:members] = members unless members.empty?

      tags={}
      e.children.select{|n| n.name == 'tag'}.each {|child|
        tags[child.values.first] = child.values[1]
      }
      element[:tags] = tags unless tags.empty?

      element
    }
  end
end
