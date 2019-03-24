require 'spec_helper'
require 'overpass_api_ruby'

describe OverpassAPI::XML do
  it 'should return the requested elements' do
    options = { bbox: { s: -34.705448, n: -34.526562,
                        w: -58.531471, e: -58.335159 },
                timeout: 900,
                element_limit: 100_000 }

    overpass = OverpassAPI::XML.new(options)

    ba_query = "<union><query type='relation'>" \
               "<has-kv k='route' v='subway'/></query>" \
               "</union><union><item/><recurse type='down'/></union>"

    expect(overpass.query(ba_query)[:elements]).to be_a(Array)
  end
end
