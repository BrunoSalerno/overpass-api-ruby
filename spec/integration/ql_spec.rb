require 'spec_helper'
require 'overpass_api_ruby'

describe OverpassAPI::QL do
  it 'should return the right elements' do
    options = { bbox: { s: -34.705448, n: -34.526562,
                        w: -58.531471, e: -58.335159 },
                timeout: 900,
                maxsize: 10_000 }

    overpass = OverpassAPI::QL.new(options)

    ba_query = "rel['route'='subway'];(._;>;);out body;"

    expect(overpass.query(ba_query)[:elements]).to be_a(Array)
  end
end
