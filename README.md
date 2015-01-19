Overpass API Ruby
=================

A Ruby wrapper for OpenStreetMap Overpass API. Returns a Hash from a query.

Usage
-----

```
require_relative 'lib/overpass_api'

ba_query = "<union><query type='relation'><has-kv k='route' v='subway'/></query>" <<
    "</union><union><item/><recurse type='down'/></union>"

options={:bbox => {:s => -34.705448,:n => -34.526562,:w => -58.531471,:e => -58.335159},
         :timeout => 900,
         :element_limit => 1073741824,
         :json => true}

overpass = OverpassAPI.new(options)
result_hash = overpass.query(ba_query)
```

Public methods
--------------

* query
* raw_query
* bbox

TODO
----
* Create a gem

License
-------
MIT.