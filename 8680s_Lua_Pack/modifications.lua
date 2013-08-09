
-- By 8680.

lp8.require "wml"
lp8.require "string"
lp8.require "utils"

lp8.newLib 'modifications'

local h, tn, ts, et, at, fx =
	lp8.helper, tonumber, tostring, {}, {lp8.AND}, {}

local function adjn(t, k, v, r)
	v = lp8.tblorudt(v) and v.increase or v
	local s, x, p = ts(v or '0'): match('^%s*([%-%+]?)%s*(%d+)%s*(%%?)%s*$')
	x, v = (s or error(("invalid %s effect value %q"): format(k, ts(v)), 2))
		~= '-' and tn(x) or -tn(x), t[k]
	t[k] = p == '%' and v*(r and 1/(x*.01+1) or x*.01+1) or r and v-x or v+x
end

local function getObjs(u, f, t)
	local u, m = lp8.to_unit_cfg(u)
	m = h.get_child(u, "modifications")
	at[2] = "object"; at[3] = f
	return m and (t and lp8.get_subtags or lp8.get_children)(m, at)
end
lp8.export(getObjs, 'get_objects')

local function getObjectTags(u, f)
	return getObjs(u, f, 1)
end
lp8.export(getObjectTags, 'get_object_tags')

local function getObjectCfgs(u, f)
	return getObjs(u, f)
end
lp8.export(getObjectCfgs, 'get_object_cfgs')

local function objects(u, f, t)
	return lp8.values(getObjs(u, f, t))
end
lp8.export(objects, 'objects')

local function objectTags(u, f)
	return lp8.values(getObjs(u, f, 1))
end
lp8.export(objectTags, 'object_tags')

local function objectCfgs(u, f)
	return lp8.values(getObjs(u, f))
end
lp8.export(objectCfgs, 'object_cfgs')

local function removeEffect(u, e)
	e = lp8.to_cfg(e, "effect")
	local t, u, proxy = e.apply_to, lp8.to_unit_cfg(u)
	for i = 1, tn(e.times == 'per level' and u.level or e.times) or 1 do
		(fx[t] or error(("don’t know how to remove %q effect"):
			format(ts(t))))(u, e, 1)
	end
	if proxy then
		wesnoth.put_unit(u)
	end
end
lp8.export(removeEffect, 'remove_effect')

local function removeObject(u, obj, fxFilt, leaveHusk, failSilently)
	local u, proxy, m, es = lp8.to_unit_cfg(u)
	obj = lp8.to_cfg(obj, "object")
	m = h.get_child(u, "modifications")
	if not m or not lp8.is_child(m, obj) then
		if failSilently then
			return
		else
			error(("unit %q does not have object %q"):
				format(ts(u.id), ts(obj.id or obj)))
		end
	end
	at[2] = "effect"; at[3] = fxFilt
	es = lp8.remove_children(obj, at, 1)
	for _, e in ipairs(es) do
		removeEffect(u, e)
	end
	if not (h.get_child(obj, "effect") or leaveHusk) then
		lp8.remove_subtag(m, function(t) return t[2] == obj end)
	end
	if proxy then
		wesnoth.put_unit(u)
	end
end
lp8.export(removeObject, 'remove_object')

local function removeObjects(u, oFilt, fxFilt, leaveHusks)
	local u, proxy = lp8.to_unit_cfg(u)
	for o in objects(u, oFilt) do
		removeObject(u, o, fxFilt, leaveHusks)
	end
	if proxy then
		wesnoth.put_unit(u)
	end
end
lp8.export(removeObjects, 'remove_objects')

function wesnoth.wml_actions.remove_object(cfg)
	cfg = h.parsed(cfg)
	local of, ef =
		lp8.get_subtag(cfg, "filter_wml"),
		lp8.get_subtag(cfg, "filter_effect")
	for _, u in pairs(wesnoth.get_units(h.get_child(cfg, "filter"))) do
		removeObjects(u, of, ef, cfg.leave_husks)
	end
end

lp8.export(fx, 'effect_handlers')

function fx.hitpoints(u,e,r)
	adjn(u, "hitpoints", e, r)
	adjn(u, "max_hitpoints", e.increase_total, r)
end
function fx.movement(u,e,r)
	adjn(u, "max_moves", e, r)
end
function fx.experience(u,e,r)
	adjn(u, "experience", e, r)
end
function fx.max_experience(u,e,r)
	adjn(u, "max_experience", e, r)
end
function fx.new_ability(u,e,r)
	u = h.get_child(u, 'abilities')
	for a in lp8.subtags(h.get_child(e, 'abilities') or et) do
		if r then
			at[2] = a[1]; at[3] = a
			lp8.erase_subtags(u, at)
		else
			u[#u+1] = a
		end
	end
end

return lp8.export()
