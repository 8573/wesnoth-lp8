
-- By 8680.

lp8.require "utils"

lp8.newLib 'string'

local tn, ts = tonumber, tostring
local vcfg = type(wesnoth) == 'table' and wesnoth.tovconfig or nil
local load = lp8.load

local function trim(s)
	-- trim5 from <http://Lua-Users.org/wiki/StringTrim>.
	return ts(s): match "^%s*(.*%S)" or ""
end
lp8.export(trim, 'trim')

local function gtrim(s)
	return ts(s): gsub("%s+", "")
end
lp8.export(gtrim, 'gtrim')

local function eval(s, e, err)
	s = ts(s)
	return (load("return " .. s, e) or type(err) == 'function'
		and err(s) or error(("can’t eval %q"): format(s)))()
end
lp8.export(eval, 'eval')

local function subst(s)
	return vcfg {s = ts(s)}.s
end
lp8.export(subst, 'subst')

local function interp(s, e)
	return ts(s): gsub("%?%b{}",
		function(x) return ts(eval(x: sub(2, -1), e)) end)
end
lp8.export(interp, 'interp')

local function strtod(s)
	s = trim(s)
	local sign = s:sub(1,1)
	if sign == '-' or sign == '+' then
		s = s:sub(2)
		sign = sign == '-' and -1 or 1
	else
		sign = 1
	end
	s = s:upper()
	if s == 'INF' or s == 'INFINITY' then
		return (1/0) * sign
	elseif s == 'NAN' or s:match 'NAN%(%w*%)' then
		return 0/0
	end
	s = tn(s)
	return s and s * sign or s
end
lp8.export(strtod, 'strtod')

return lp8.export()
