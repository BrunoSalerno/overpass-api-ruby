require 'spec_helper'
require 'overpass_api_ruby'

describe OverpassAPI::QL do
  it 'should return the right built query when no opts are passed' do
    overpass = OverpassAPI::QL.new
    built_query = overpass.build_query('a query')

    expect(built_query).to eq '[out:json];a query'
  end

  it 'should set the right opts' do
    opts = { bbox: { s: 1, n: 2, w: 3, e: 4 },
             timeout: 1000,
             maxsize: 333 }

    overpass = OverpassAPI::QL.new(opts)
    built_query = overpass.build_query('a query')

    expected_built_query = '[bbox:1,3,2,4][timeout:1000]' \
                           '[maxsize:333][out:json];a query'
    expect(built_query).to eq expected_built_query
  end
end
