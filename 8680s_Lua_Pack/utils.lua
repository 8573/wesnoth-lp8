
-- By 8680.

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
	else
		error("don’t know how to flip a " .. ty)
	end
end

local wmlVars = lp8.helper.set_wml_var_metatable {}
lp8.wml_vars

function lp8.interpolate(s, e)
	e = e or wmlVars
	return s: gsub()
end

