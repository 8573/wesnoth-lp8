
-- By 8680.

lp8.require "utils"

local type, match = type

local function isCfg(x)
	return getmetatable(x) == 'wml object'
end
lp8.is_cfg = isCfg

local function isTag(x)
	if type(x) ~= 'userdata' and type(x) ~= 'table' then
		return false
	end
	local s, c = pcall(function()
		return #x == 2 and type(x[1]) == 'string' and x[2]
	end)
	return s and c and (type(c) == 'table' or type(c) == 'userdata')
end
lp8.is_tag = isTag

local function toCfg(x, f)
	return isTag(x) and (match(x) and x[2] or error(
		("expected tag input to match filter %q"): format(tostring(f)))) or x
end
lp8.to_cfg = toCfg

local function toTag(x, name)
	return isTag(x) and x or {name or "dummy", x}
end
lp8.to_tag = toTag

function lp8.is_subtag(p, c)
	p = toCfg(p)
	for i = 1, #p do
		if p[i] == c then
			return true
		end
	end
end

function lp8.is_child(p, c)
	p = toCfg(p)
	for i = 1, #p do
		if p[i][2] == c then
			return true
		end
	end
end

function lp8.tags_equal(x, y)
	return x[1] == y[1] and match(x, y) and match(y, x)
end

function lp8.cfgs_equal(x, y)
	return lp8.tags_equal(toTag(x), toTag(y))
end

local function getSubtag(p, f, n, i)
	p = toCfg(p)
	n = n or 1
	for i = i or 1, #p do
		if match(p[i], f) then
			n = n-1
			if n <= 0 then
				return p[i], i
			end
		end
	end
end
lp8.get_subtag = getSubtag

function lp8.subtags(p, f, i)
	return function(s)
		local t, i = getSubtag(p, f, 1, s.i)
		s.i = i
		return t, i
	end, {i = i or 1}
end

function lp8.children(p, f, i)
	return function(s)
		local c, i = getSubtag(p, f, 1, s.i)
		s.i = i
		return c[2], i
	end, {i = i or 1}
end

function lp8.get_subtags(p, f)
	local r = {}
	for t in lp8.subtags(p, f) do
		r[#r+1] = t
	end
	return r
end

function lp8.get_child(p, f, n, i)
	p, i = getSubtag(p, f, n, i)
	return p[2], i
end

function lp8.get_children(p, f)
	local r = {}
	for c in lp8.children(p, f) do
		r[#r+1] = c
	end
	return r
end

local tr = table.remove

local function removeSubtag(p, f, n, i)
	p = toCfg(p)
	n = n or 1
	for i = i or 1, #p do
		if match(p[i], f) then
			n = n-1
			if n <= 0 then
				local t = p[i]
				tr(p, i)
				return t, i
			end
		end
	end
end
lp8.remove_subtag = removeSubtag

function lp8.remove_child(p, f, n, i)
	p, i = removeSubtag(p, f, n, i)
	return p[2], i
end

function lp8.remove_subtags(p, f)
	p = toCfg(p)
	local r = {}
	for i = #p, 1, -1 do
		if match(p[i], f) then
			r[#r+1] = p[i]
			tr(p, i)
		end
	end
	return lp8.flip(r)
end

function lp8.remove_children(p, f)
	p = toCfg(p)
	local r = {}
	for i = #p, 1, -1 do
		if match(p[i], f) then
			r[#r+1] = p[i][2]
			tr(p, i)
		end
	end
	return lp8.flip(r)
end

function lp8.erase_subtags(p, f)
	p = toCfg(p)
	for i = #p, 1, -1 do
		if match(p[i], f) then
			tr(p, i)
		end
	end
end

function lp8.is_unit_proxy(x)
	return getmetatable(x) == 'unit'
end

function match(t, f)
	local ty = type(f)
	if ty == 'string' then
		return t[1] == f
	elseif ty == 'function' then
		return f(t)
	elseif isTag(f) then
		t, f = t[2], f[2]
		if t == f then
			return true
		end
		for k, v in pairs(f) do
			if type(k) == 'string' and t[k] ~= v then
				return false
			end
		end
		local n, i = {}, {}
		for k, v in ipairs(f) do
			if isTag(v) then
				k = v[1]; v, i[k] = getSubtag(t, {lp8.AND, k, v}, n[k], i[k])
				if v then
					n[k] = (n[k] or 1) + 1
				else
					return false
				end
			end
		end
		return true
	elseif ty == 'table' then
		ty = f[1]
		if ty ~= lp8.AND and ty ~= lp8.OR then
			error "expected Boolean operation constant as first element of tag filter list"
		end
		for i = 2, #f do
			if lp8.flip(match(t, f[i]), ty ~= lp8.OR) then
				return ty == lp8.OR
			end
		end
		return ty ~= lp8.OR
	elseif ty == 'boolean' then
		return f
	end
	return f == nil or error(ty .. "s as filters not supported", 2)
end
lp8.match_tag = match

function lp8.to_unit_cfg(u)
	local p = lp8.is_unit_proxy(u); return p and u.__cfg
		or (type(u) == 'table' or type(u) == 'userdata') and u or error(
			("expected unit proxy or unit cfg; received %s with metatable %q"):
				format(type(u), tostring(getmetatable(u)))), p
end
