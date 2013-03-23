
-- By 8680.

lp8.require "utils"

local ts = tostring

function lp8.trim(s)
	-- trim5 from [http://Lua-Users.org/wiki/StringTrim].
	return ts(s): match "^%s*(.*%S)" or ""
end

local function eval(s, e)
	s = ts(s)
	return (lp8.load("return " .. s) or error(("can’t eval %q"): format(s)))()
end
lp8.eval = eval

function lp8.subst(s)
	return wesnoth.tovconfig {s = ts(s)}.s
end

function lp8.interp(s, e)
	return ts(s): gsub("%?%b{}", function(x) return eval(x: sub(2, -1), e) end)
end
