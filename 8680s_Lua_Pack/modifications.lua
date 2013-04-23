
-- By 8680.

lp8.require "wml"
lp8.require "strings"
lp8.require "utils"

local h, tn, ts, fx = lp8.helper, tonumber, tostring, {}

local function adjn(t, k, v, r)
	v = lp8.tblorudt(v) and v.increase or v
	local s, x, p = ts(v or '0'): match('^%s*([%-%+]?)%s*(%d+)%s*(%%?)%s*$')
	x, v = (s or error(("invalid %s effect value %q"): format(k, ts(v)), 2))
		~= '-' and tn(x) or -tn(x), t[k]
	t[k] = p and v*(r and 1/(x*.01+1) or x*.01+1) or r and v-x or v+x
end

function getObjs(u, f, t)
	local u, m = lp8.to_unit_cfg(u)
	m = h.get_child(u, "modifications")
	return m and (t and lp8.get_children or lp8.get_subtags)
		(m, {lp8.AND, "object", f})
end
lp8.get_objects = getObjs

function lp8.get_object_tags(u, f)
	return getObjs(u, f, 1)
end

function lp8.get_object_cfgs(u, f)
	return getObjs(u, f)
end

function lp8.objects(u, f, t)
	return lp8.values(getObjs(u, f, t))
end

function lp8.object_tags(u, f)
	return lp8.values(getObjs(u, f, 1))
end

function lp8.object_cfgs(u, f)
	return lp8.values(getObjs(u, f))
end

function lp8.remove_effect(u, e)
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

function lp8.remove_object(u, obj, fxFilt, leaveHusk, failSilently)
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
	es = lp8.remove_children(obj, {lp8.AND, "effect", fxFilt}, 1)
	for _, e in ipairs(es) do
		lp8.remove_effect(u, e)
	end
	if not (h.get_child(obj, "effect") or leaveHusk) then
		lp8.remove_subtag(m, function(t) return t[2] == obj end)
	end
	if proxy then
		wesnoth.put_unit(u)
	end
end

function wesnoth.wml_actions.remove_object(cfg)
	cfg = h.parsed(cfg)
	lp8.remove_object(wesnoth.get_units(h.get_child(cfg, "filter")),
		h.get_child(cfg, "filter_wml"), h.get_child(cfg, "filter_effect"))
end

lp8.effect_handlers = fx

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
