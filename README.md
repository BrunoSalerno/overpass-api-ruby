Overpass API Ruby
=================

A Ruby wrapper for OpenStreetMap Overpass API. Returns a Hash from a query.

Install
-------

`gem install overpass-api-ruby`

or add `gem 'overpass-api-ruby'` to your Gemfile

Usage
-----

```ruby
require 'overpass_api_ruby'

ba_query = "<union><query type='relation'><has-kv k='route' v='subway'/></query>" <<
    "</union><union><item/><recurse type='down'/></union>"

options={:bbox => {:s => -34.705448, :n => -34.526562,
                   :w => -58.531471, :e => -58.335159},
         :timeout => 900,
         :element_limit => 1073741824,
         :json => true}

overpass = OverpassAPI.new(options)
result_hash = overpass.query(ba_query)
```

Options on instantiation
------------------------
```
bbox                    Hash. Global bounding box.
endpoint                String. 
                        Defaults to http://overpass-api.de/api/interpreter
timeout                 Integer.
element_limit           Integer.
json                    Boolean. API response is in JSON format, so parse to hash 
                        doesn't use the private parse_nokogiri method. 
                        Default: false.
cache_expiration_time   Integer. Default: 7200.
dont_use_cache          Boolean. Default: false.
```
See [Overpass API](http://wiki.openstreetmap.org/wiki/Overpass_API/Language_Guide)

Public methods
--------------

```ruby
query (<String query>)      Intended to pass only children tags of <osm-script>.

raw_query (<String query>)  The whole query must be passed.

bbox (s,n,w,e)              Defines global bounding box.
```


License
-------
MIT.
