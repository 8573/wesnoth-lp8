
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


`lp8.eval(string, env)`
-------------------------------------------------------------------------------
Evaluates `string` as a Lua expression.

`env` is the environment in which to evaluate the expression; it defaults to
the global environment.


`lp8.flip(x)`
-------------------------------------------------------------------------------
Flips `x` however makes sense.

* If `x` is a string, returns `string.reverse(x)`.
* If `x` is a number, returns `-x`.
* If `x` is a Boolean, returns `not x`.
* If `x` is a table, returns a new table with all values of `x` with integer
  keys from `1` to `#x`, in reverse order.


`lp8.subst(string)`
-------------------------------------------------------------------------------
Interpolates (substitutes) WML variables and formulae in `string`.

Returns a copy of `string` with (e.g.) "$unit.id $(3+5)" replaced with
"Konrad 8".


`lp8.interp(string, env)`
-------------------------------------------------------------------------------
Interpolates Lua expressions embedded in `string`, with the syntax `?{expr}`.

Returns a copy of `string` with (e.g.) "?{3+5}" replaced with "8".

`env` is the environment in which to evaluate the expressions; it defaults to
the global environment.


`lp8.wml_vars`
-------------------------------------------------------------------------------
A WML variables interface table, as created by `helper.set_wml_var_metatable`.

