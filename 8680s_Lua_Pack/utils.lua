
-- By 8680.

local function load8(ld, env, name)
	if not loadstring then
		return load(ld, name, nil, env)
	else
		ld = (type(ld) == 'string' and loadstring or
			type(ld) == 'function' and load or
			error("expected string or function as first argument; received "
				.. ty))(ld, name)
		return ld and setfenv(ld, env)
	end
end
lp8.load = load8

local function eval(s, e)
	s = tostring(s)
	return (load8("return " .. s) or error(("can’t eval %q"): format(s)))()
end
lp8.eval = eval

function lp8.flip(x)
	local ty = type(x)
	if ty == 'table' then
		local r = {}
		for i = #x, 1, -1 do
			r[#r+1] = x[i]
		end
		return r
	elseif ty == 'string' then
		return x: reverse()
	elseif ty == 'number' then
		return -x
	elseif ty == 'boolean' then
		return not x
	end
	error("don’t know how to flip a " .. ty)
end

lp8.wml_vars = lp8.helper.set_wml_var_metatable {}

function lp8.subst(s)
	return wesnoth.tovconfig {s=s}.s
end

function lp8.interp(s, e)
	return tostring(s):
		gsub("%?%b{}", function(x) return eval(x: sub(2, -1), e) end)
end

