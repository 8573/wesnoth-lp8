
String manipulation utilities.
===============================================================================

All functions in this library that have a `string` parameter pass that
parameter through `tostring` before processing it.


`lp8.trim(string)`
-------------------------------------------------------------------------------
Returns a copy of `string` with leading and trailing whitespace removed.

E.g., `lp8.trim " 8680’s Lua Pack  "` returns `"8680’s Lua Pack"`.


`lp8.gtrim(string)`
-------------------------------------------------------------------------------
Returns a copy of `string` with all whitespace removed.

E.g., `lp8.gtrim " 8680’s Lua Pack  "` returns `"8680’sLuaPack"`.


`lp8.eval(string, env, err)`
-------------------------------------------------------------------------------
Evaluates `string` as a Lua expression.

`env` is the environment in which to evaluate the expression; it defaults to
the global environment.

`err` is an optional function to be called with `string` as an argument in the
event of an error; it defaults to issuing a generic error message: `can’t eval
<string>`.


`lp8.subst(string)`
-------------------------------------------------------------------------------
Interpolates (substitutes) WML variables and formulae in `string`.

Returns a copy of `string` with (e.g.) `$unit.id $(3+5)` replaced with `Konrad
8`.


`lp8.interp(string, env)`
-------------------------------------------------------------------------------
Interpolates Lua expressions embedded in `string`, with the syntax `?{expr}`.

Returns a copy of `string` with (e.g.) `?{3+5}` replaced with `8`.

`env` is the environment in which to evaluate the expressions; it defaults to
the global environment.


`lp8.strtod(string)`
-------------------------------------------------------------------------------
Converts a string to a number like the C standard library function `strtod`.

Functions like `tonumber`, and additionally understands (case-insensitively)
the keywords `Infinity` (or `Inf`) and `NaN` (Not-a-Number).
