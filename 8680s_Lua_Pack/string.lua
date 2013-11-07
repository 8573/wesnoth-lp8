
-- By 8680.

lp8.require "utils"

lp8.newLib 'string'

local ts = tostring
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

return lp8.export()
