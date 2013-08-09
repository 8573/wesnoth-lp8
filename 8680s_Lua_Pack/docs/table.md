
Table utilities library.
===============================================================================

`lp8.copyTable(table, target, noOverwrite)`
-------------------------------------------------------------------------------
Copies the key-value pairs of table `table` to table `target`.

Unless `noOverwrite` is truthy, keys of `target` that are also present in
`table` will have their values overwritten with the values of the
corresponding keys of `table`.

If `target` is falsy, it defaults to a new empty table.

Returns `target`.
