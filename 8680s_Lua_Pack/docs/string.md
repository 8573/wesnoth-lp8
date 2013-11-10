
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


`lp8.parse_wml_value(string)`
-------------------------------------------------------------------------------
Parses a WML value from `string`, generally like the Wesnoth engine would.

Returns a Boolean if `string` is a WML Boolean keyword (see
`parse_wml_boolean`); returns a number if `string` is a valid number (including
infinity and NaN; see `strtod`) and can be converted to a number without loss
of information; returns the original string otherwise.


`lp8.parse_wml_boolean(string)`
-------------------------------------------------------------------------------
Parses a WML Boolean value from `string`. Returns true if `string` is `yes` or
`true`; returns false if `string` is `no` or `false`; returns nil otherwise.


`lp8.pattern_escape(string)`
-------------------------------------------------------------------------------
Returns `string`, with each occurrence of `^`, `$`, `(`, `)`, `%`, `.`, `[`,
`]`, `*`, `+`, `-`, or `?` in it escaped by prefixing it with `%`, such that
the returned string is suitable for use in a pattern for `string.match` etc.


`lp8.is_identifier(string)`
-------------------------------------------------------------------------------
Returns whether `string` is a valid C-style identifier (note: Lua uses C-style
identifiers), that is, whether it consists solely of one or more US-ASCII
alphanumeric characters and/or underscores, of which the first is not a digit.
