require 'spec_helper'
require 'overpass_api_ruby'

describe OverpassAPI do
  describe OverpassAPI::XML do
    it "'s example works" do
      options={:bbox => {:s => -34.705448, :n => -34.526562,
                         :w => -58.531471, :e => -58.335159},
               :timeout => 900}

      overpass = OverpassAPI::XML.new(options)

      ba_query = "<union><query type='relation'><has-kv k='route' v='subway'/></query>" <<
        "</union><union><item/><recurse type='down'/></union>"


      expect(overpass.query(ba_query)[:elements]).to be_a(Array)
    end
  end

  describe OverpassAPI::QL do
    it "'s example works" do
      options={:bbox => {:s => -34.705448, :n => -34.526562,
                         :w => -58.531471, :e => -58.335159},
               :timeout => 900}

      overpass = OverpassAPI::QL.new(options)

      ba_query = "rel['route'='subway'];(._;>;);out body;"

      expect(overpass.query(ba_query)[:elements]).to be_a(Array)
    end
  end
end
