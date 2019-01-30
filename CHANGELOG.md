CHANGELOG
=========
v 0.3
-----
- Use POST instead of GET.
- Update rake to version 2.0.6 because of a GitHub vulnerability alert.

v 0.2.3
--------
Removes param `data` from ENDPOINT constant (Issue #5)

v 0.2.2
-------
Fixes `maxsize` option in the `XML` class. (Issue #4)

v 0.2
-----
BREAKING CHANGES
The addition of XML and QL classes breaks the compatibility with previous versions. Also, the `element_limit` option was deprecated, so now it's named `maxsize`. Check the examples.
