Overpass API Ruby
=================

A Ruby wrapper for OpenStreetMap Overpass API. Supports both QL and XML.

Note: Version 0.2 introduces breaking changes. Check the file CHANGELOG.md.

Install
-------

`gem install overpass-api-ruby`

or add `gem 'overpass-api-ruby'` to your Gemfile

Usage
-----

Using XML:

```ruby
require 'overpass_api_ruby'

options={:bbox => {:s => -34.705448, :n => -34.526562,
                   :w => -58.531471, :e => -58.335159},
         :timeout => 900,
         :maxsize => 1073741824}

overpass = OverpassAPI::XML.new(options)

query = "<union><query type='relation'><has-kv k='route' v='subway'/></query>" <<
        "</union><union><item/><recurse type='down'/></union>"

response = overpass.query(query)
```

Using QL:

```ruby
require 'overpass_api_ruby'

options={:bbox => {:s => -34.705448, :n => -34.526562,
                   :w => -58.531471, :e => -58.335159},
         :timeout => 900,
         :maxsize => 1073741824}

overpass = OverpassAPI::QL.new(options)

query = "rel['route'='subway'];(._;>;);out body;"

response = overpass.query(query)
```

Options on instantiation
------------------------
```
bbox                    Hash. Global bounding box.
endpoint                String.
                        Defaults to http://overpass-api.de/api/interpreter
timeout                 Integer.
maxsize                 Integer.
```
See [Overpass API](http://wiki.openstreetmap.org/wiki/Overpass_API/Language_Guide)

Public methods
--------------

Both `QL` and `XML` classes have the same public methods:

```ruby
query (<String query>)      Performs the query passed using the global values set on instantiation.

raw_query (<String query>)  The whole query must be passed.

buid_query (<String query>) Returns a String containing the whole query.

bounding_box (s,n,w,e)      Defines the global bounding box.
```


License
-------
MIT.
