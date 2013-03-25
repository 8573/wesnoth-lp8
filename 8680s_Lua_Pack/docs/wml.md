
For more easily manipulating WML objects (`cfg`s) in Lua.
===============================================================================

An `index` argument can be omitted, in which case it defaults to 1.


**NOTE**: When I say “tag” or “subtag”, I mean the whole thing, e.g.:

	{"gold",{ side=1, amount=100 }}

Not just the contents, like what `helper.get_child` returns, e.g.:

	{ side=1, amount=100 }


`lp8.is_tag(x)`
-------------------------------------------------------------------------------
Returns whether `x` is (or at least looks like) a WML tag object.


`lp8.match_tag(tag, filter)`
-------------------------------------------------------------------------------
Returns whether `tag` matches `filter`.

`filter` can be a string, a function, a Boolean, a WML tag object, a list of
filters, or nil.

* A string filter matches if it equals the tag’s name.
* A function filter matches if `filter(tag)` is truthy.
* A tag object filter matches if `tag` contains its contents; that is, for each
  key in `filter`, `tag` has a key with the same name and value, and, for each
  subtag in `filter`, `tag` has a subtag with the same name for which
  `match_tag(tag_subtag, filter_subtag)` returns true.
* A list filter matches if any of its contained filters match.
* A Boolean filter matches if it is true.
* A nil filter always matches (like an empty filter in WML).

This is the function used to match tags to filters by the other functions.


`lp8.tags_equal(tag1, tag2)`
-------------------------------------------------------------------------------
Returns whether `tag1` and `tag2` are structurally equal.


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


`lp8.subtags(cfg, filter)`
-------------------------------------------------------------------------------
Returns an iterator over all matching subtags of `cfg`.


`lp8.chilren(cfg, filter)`
-------------------------------------------------------------------------------
Returns an iterator over the contents of all matching subtags of `cfg`.


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

