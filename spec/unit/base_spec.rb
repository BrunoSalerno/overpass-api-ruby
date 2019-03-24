require 'spec_helper'
require 'overpass_api_ruby'
require 'httpi'

# rubocop:disable Metrics/BlockLength
describe OverpassAPI::Base do
  it 'should return the default endpoint' do
    expect(OverpassAPI::Base::DEFAULT_ENDPOINT).to eq 'http://overpass-api.de/api/interpreter'
    base = OverpassAPI::Base.new
    expect(
      base.instance_variable_get('@endpoint')
    ).to eq OverpassAPI::Base::DEFAULT_ENDPOINT
  end

  it 'should set the right args' do
    opts = { bbox: { s: 1, n: 2, w: 3, e: 4 },
             endpoint: 'a.endpoint.com',
             timeout: 1000 }

    base = OverpassAPI::Base.new(opts)

    expect(base.instance_variable_get('@bbox')).to eq '1,3,2,4'
    expect(base.instance_variable_get('@endpoint')).to eq 'a.endpoint.com'
    expect(base.instance_variable_get('@timeout')).to eq 1000
  end

  it 'should set the bounding box' do
    base = OverpassAPI::Base.new
    base.bounding_box(10, 20, 30, 40)

    expect(base.instance_variable_get('@bbox')).to eq '10,30,20,40'
  end

  it 'should try to perform the query' do
    base = OverpassAPI::Base.new

    query = 'a query'
    built_query = 'built_query'
    expected_response = 'a response'

    allow(base).to receive(:perform).and_return(expected_response)
    allow(base).to receive(:build_query).and_return(built_query)

    expect(base).to receive(:build_query).with(query)
    expect(base).to receive(:perform).with(built_query)

    response = base.query(query)

    expect(response).to eq expected_response
  end

  it 'should try to perform a raw query' do
    base = OverpassAPI::Base.new

    query = 'as query'
    expected_response = 'a response'

    allow(base).to receive(:perform).and_return(expected_response)
    expect(base).to receive(:perform).with(query)

    response = base.raw_query(query)

    expect(response).to eq expected_response
  end

  it 'should try to perform an http request' do
    base = OverpassAPI::Base.new

    query = 'a query'
    request = 'a request'
    body = { key: 'value' }

    allow(HTTPI::Request).to receive(:new).and_return(request)
    expect(
      HTTPI::Request
    ).to receive(:new).with(
      url: OverpassAPI::Base::DEFAULT_ENDPOINT,
      body: query
    )

    allow(
      HTTPI
    ).to receive(:post).and_return(
      OpenStruct.new(body: body.to_json)
    )
    expect(HTTPI).to receive(:post).with(request)

    response = base.raw_query(query)
    expect(response).to eq body
  end
end
# rubocop:enable Metrics/BlockLength
