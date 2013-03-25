
-- By 8680.

local match

local function getSubtag(cfg, f, n, i)
	n = n or 1
	for i = i or 1, #cfg do
		if match(cfg[i], f) then
			n = n-1
			if n <= 0 then
				return cfg[i], i
			end
		end
	end
end
lp8.get_subtag = getSubtag

function lp8.subtags(cfg, f, i)
	return function(s)
		local t, i = getSubtag(cfg, f, 1, s.i)
		s.i = i
		return t, i
	end, {i = i or 1}
end

function lp8.children(cfg, f, i)
	return function(s)
		local c, i = getSubtag(cfg, f, 1, s.i)
		s.i = i
		return c[2], i
	end, {i = i or 1}
end

function lp8.get_subtags(cfg, f)
	local r = {}
	for t in lp8.subtags(cfg, f) do
		r[#r+1] = t
	end
	return r
end

function lp8.get_child(cfg, f, n, i)
	cfg, i = getSubtag(cfg, f, n, i)
	return cfg[2], i
end

function lp8.get_children(cfg, f)
	local r = {}
	for c in lp8.children(cfg, f) do
		r[#r+1] = c
	end
	return r
end

local tr = table.remove

local function removeSubtag(cfg, f, n, i)
	n = n or 1
	for i = i or 1, #cfg do
		if match(cfg[i], f) then
			n = n-1
			if n <= 0 then
				local t = cfg[i]
				tr(cfg, i)
				return t, i
			end
		end
	end
end
lp8.remove_subtag = removeSubtag

function lp8.remove_child(cfg, f, n, i)
	cfg, i = removeSubtag(cfg, f, n, i)
	return cfg[2], i
end

function lp8.remove_subtags(cfg, f)
	local r = {}
	for i = #cfg, 1, -1 do
		if match(cfg[i], f) then
			r[#r+1] = cfg[i]
			tr(cfg, i)
		end
	end
	return lp8.flip(r)
end

function lp8.remove_children(cfg, f)
	local r = {}
	for i = #cfg, 1, -1 do
		if match(cfg[i], f) then
			r[#r+1] = cfg[i][2]
			tr(cfg, i)
		end
	end
	return lp8.flip(r)
end

function lp8.erase_subtags(cfg, f)
	for i = #cfg, 1, -1 do
		if match(cfg[i], f) then
			tr(cfg, i)
		end
	end
end

local function isTag(x)
	if type(x) ~= 'userdata' and type(x) ~= 'table' then
		return false
	end
	local s, c = pcall(function() return type(x[1]) == 'string' and x[2] end)
	return s and c and (type(c) == 'table' or type(c) == 'userdata')
end
lp8.is_tag = isTag

function match(t, f)
	local ty = type(f)
	if ty == 'string' then
		return t[1] == f
	elseif ty == 'function' then
		return f(t)
	elseif isTag(f) then
		if t[1] ~= f[1] then
			return false
		end
		t, f = t[2], f[2]
		for k, v in pairs(f) do
			if type(k) == 'string' and t[k] ~= v then
				return false
			end
		end
		local n, i = {}, {}
		for k, v in ipairs(f) do
			if isTag(v) then
				k = v[1]; v, i[k] = getSubtag(t, v, n[k], i[k])
				if v then
					tn[k] = (tn[k] or 1) + 1
				else
					return false
				end
			end
		end
		return true
	elseif ty == 'table' then
		for i = 1, #f do
			if match(t, f[i]) then
				return true
			end
		end
		return false
	elseif ty == 'boolean' then
		return f
	end
	return f == nil or error(ty .. "s as filters not supported", 2)
end
lp8.match_tag = match

function lp8.tags_equal(x, y)
	return match(x, y) and match(y, x)
end
