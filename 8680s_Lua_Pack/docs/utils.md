
Miscellaneous utilities.
===============================================================================

`lp8.load(ld, env, source)`
-------------------------------------------------------------------------------
Emulates a subset of the Lua 5.2 `load` function’s functionality in 5.2 or 5.1.

Returns a function compiled from `ld`.

`ld` can be:
  a string containing Lua source text;
  a string containing Lua bytecode; or
  a function, which is repeatedly called until it returns `""` or `nil`, and
	its results are concatenated and interpreted as one of the above.

`env` is the environment the function will use; it defaults to the global
environment.

`source` is an optional name for whatever’s being loaded, for error reporting.


`lp8.flip(x, control)`
-------------------------------------------------------------------------------
Flips `x` however makes sense.

* If `x` is a string, returns `string.reverse(x)`.
* If `x` is a number, returns `-x`.
* If `x` is a Boolean, returns `not x`.
* If `x` is a table, returns a new table with all values of `x` with integer
  keys from `1` to `#x`, in reverse order.

If `control` is false (but not nil), `x` is not flipped but returned as is.


`lp8.wml_vars`
-------------------------------------------------------------------------------
A WML variables interface table, as created by `helper.set_wml_var_metatable`.


`lp8.AND`, `lp8.OR`
-------------------------------------------------------------------------------
Opaque constants. Their semantics are defined by functions that take them.

