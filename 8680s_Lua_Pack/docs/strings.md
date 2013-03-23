
String manipulation utilities.
===============================================================================

`lp8.trim(string)`
-------------------------------------------------------------------------------
Returns a copy of `string` sans leading and trailing whitespace.

E.g., `lp8.trim " lp8  "` returns `"lp8"`.


`lp8.eval(string, env)`
-------------------------------------------------------------------------------
Evaluates `string` as a Lua expression.

`env` is the environment in which to evaluate the expression; it defaults to
the global environment.


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

