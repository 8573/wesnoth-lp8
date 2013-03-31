
For manipulating [object]s and other modifications.
===============================================================================

`lp8.remove_effect(unit, effect)`
-------------------------------------------------------------------------------
Removes the given `effect` (a tag or cfg) from `unit` (a cfg or proxy).

The effect need not have ever been applied to the unit.

Does not remove the effect tag itself from the unit. If the unit advances, the
effect may be reapplied.


`lp8.remove_object(unit, object, effect_filter, leave_husk)`
-------------------------------------------------------------------------------
Removes from the given `unit` (which may be a cfg or proxy) all [effect]s of
the given `object` (a tag or cfg) that match `effect_filter` (which may be any
type of filter supported by `wml/match_tag`).

If all [effect]s of the `object` are removed, the remnants of the `object` will
be deleted, unless `leave_husk` is truthy.

