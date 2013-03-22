
-- By 8680.

local function match(t, f)
	local ty = type(f)
	if ty == 'string' then
		return t[1] == f
	elseif ty == 'function' then
		return f(t)
	elseif ty == 'table' then
		for i = 1, #f do
			if match(t, f[i]) then
				return true
			end
		end
	elseif ty == 'boolean' then
		return f
	else
		return f == nil or error(ty .. "s as filters not supported", 2)
	end
end
lp8.match_tag = match

local function getSubtag(cfg, f, n)
	n = n or 1
	for i = 1, #cfg do
		if match(cfg[i], f) then
			n = n-1
			if n <= 0 then
				return cfg[i]
			end
		end
	end
end
lp8.get_subtag = getSubtag

function lp8.get_subtags(cfg, f)
	local r = {}
	for i = 1, #cfg do
		if match(cfg[i], f) then
			r[#r+1] = cfg[i]
		end
	end
	return r
end

function lp8.get_child(cfg, f, n)
	return getSubtag(cfg, f, n)[2]
end

function lp8.get_children(cfg, f)
	local r = {}
	for i = 1, #cfg do
		if match(cfg[i], f) then
			r[#r+1] = cfg[i][2]
		end
	end
	return r
end

local tr = table.remove

local function removeSubtag(cfg, f, n)
	n = n or 1
	for i = 1, #cfg do
		if match(cfg[i], f) then
			n = n-1
			if n <= 0 then
				local t = cfg[i]
				tr(cfg, i)
				return t
			end
		end
	end
end
lp8.remove_subtag = removeSubtag

function lp8.remove_child(cfg, f, n)
	return removeSubtag(cfg, f, n)[2]
end

lp8.require "utils"

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

