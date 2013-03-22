
For more easily manipulating WML objects (`cfg`s) in Lua.
===============================================================================

A `filter` can be a string, a function, a Boolean, a list of filters, or `nil`.

* A string matches if it equals the subtag’s tag name.
* A function matches if `filter(subtag)` is truthy.
* A list matches if any of its contained filters match.
* A Boolean matches if it is true.
* `nil` always matches (like an empty filter in WML).


An `index` can be omitted, in which case it defaults to 1.


**NOTE**: When I say “tag” or “subtag”, I mean the whole thing, e.g.:

	{"gold",{ side=1, amount=100 }}

Not just the contents, like what `helper.get_child` returns, e.g.:

	{ side=1, amount=100 }


`lp8.get_subtag(cfg, filter, index)`
-------------------------------------------------------------------------------
Returns the `index`-th matching subtag of `cfg`.


`lp8.get_child(cfg, filter, index)`
-------------------------------------------------------------------------------
Returns the contents (like `helper.get_child`) of the `index`-th matching
subtag of `cfg`.


`lp8.get_subtags(cfg, filter)`
-------------------------------------------------------------------------------
Returns a list containing each matching subtag of `cfg`.


`lp8.get_children(cfg, filter)`
-------------------------------------------------------------------------------
Returns a list containing the contents of each matching subtag of `cfg`.


`lp8.remove_subtag(cfg, filter, index)`
-------------------------------------------------------------------------------
Removes the `index`-th matching subtag of `cfg`.
Returns the removed subtag.


`lp8.remove_child(cfg, filter, index)`
-------------------------------------------------------------------------------
Removes the `index`-th matching subtag of `cfg`.
Returns the contents of the removed subtag.


`lp8.remove_subtags(cfg, filter)`
-------------------------------------------------------------------------------
Removes each matching subtag of `cfg`.
Returns a list containing each removed subtag.


`lp8.remove_children(cfg, filter)`
-------------------------------------------------------------------------------
Removes each matching subtag of `cfg`.
Returns a list containing the contents of each removed subtag.


`lp8.erase_subtags(cfg, filter)`
-------------------------------------------------------------------------------
Like `remove_subtags`, but doesn’t save the erased subtags.


