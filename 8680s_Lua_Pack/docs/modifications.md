
For manipulating [object]s and other modifications.
===============================================================================

`lp8.get_objects(unit, filter, full_tags)`
-------------------------------------------------------------------------------
Returns a list of the contents of each [object] tag in the `unit`’s
[modifications] that matches `filter`.

If `full_tags` is truthy, returns the tags, rather than only their contents.


`lp8.get_object_tags(unit, filter)`
-------------------------------------------------------------------------------
Equivalent to `lp8.get_objects(unit, filter, true)`.


`lp8.get_object_cfgs(unit, filter)`
-------------------------------------------------------------------------------
Equivalent to `lp8.get_objects(unit, filter, false)`.


`lp8.remove_effect(unit, effect)`
-------------------------------------------------------------------------------
Removes the given `effect` (a tag or cfg) from `unit` (a cfg or proxy).

The effect need not have ever been applied to the unit.

Does not remove the effect tag itself from the unit (it couldn’t, if the effect
had never been applied to the unit). If the effect tag was stored in the unit,
and the unit advances, the effect may be reapplied if the effect tag is not
removed first.


`lp8.remove_object(unit, object, effect_filter, leave_husk, fail_silently)`
-------------------------------------------------------------------------------
Removes from the given `unit` (which may be a cfg or proxy) all [effect]s of
the given `object` (a tag or cfg) that match `effect_filter` (which may be any
type of filter supported by `wml/match_tag`).

The object must be a subtag or child of the unit’s [modifications] subtag; i.e.
it must have been applied to the unit at some point.

If the object is not in the unit’s [modifications], or if the unit has no
[modifications], an error will be raised, unless `fail_silently` is truthy.

If all [effect]s of the object are removed, the remnants of the object will
be deleted, unless `leave_husk` is truthy.

