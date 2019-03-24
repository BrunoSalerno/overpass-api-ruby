require 'spec_helper'
require 'overpass_api_ruby'

describe OverpassAPI::XML do
  it 'should return the right built query when no opts are passed' do
    overpass = OverpassAPI::XML.new
    built_query = overpass.build_query('a query')

    expect(built_query).to eq "<osm-script output='json'>a query" \
                              '<print/></osm-script>'
  end

  it 'should set the right opts' do
    opts = { bbox: { s: 1, n: 2, w: 3, e: 4 },
             timeout: 1000,
             element_limit: 333 }

    overpass = OverpassAPI::XML.new(opts)
    built_query = overpass.build_query('a query')

    expected_built_query = "<osm-script bbox='1,3,2,4' timeout='1000' " \
                           "element-limit='333' output='json'>" \
                           'a query<print/></osm-script>'
    expect(built_query).to eq expected_built_query
  end
end
