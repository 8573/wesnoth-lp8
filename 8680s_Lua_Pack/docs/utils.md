
Miscellaneous utilities.
===============================================================================

`lp8.flip(x)`
-------------------------------------------------------------------------------
Flips `x` however makes sense.

* If `x` is a string, returns `string.reverse(x)`.
* If `x` is a number, returns `-x`.
* If `x` is a Boolean, returns `not x`.
* If `x` is a table, returns a new table with all values of `x` with integer
  keys from `1` to `#x`, in reverse order.


`lp8.interpolate(string)`
-------------------------------------------------------------------------------
Interpolates variables in `string` like in WML.


`lp8.wml_vars`
-------------------------------------------------------------------------------
A WML variables interface table, as created by `helper.set_wml_var_metatable`.


