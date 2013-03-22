
-- By 8680, with help from battlestar (testing) and Elvish_Hunter (suggestion
-- for $this_attack).

lp8.require "match_attack"

local load, h, stringAttackKeys, numericAttackKeys, varSubstBox =
	loadstring or load, lp8.helper
	{	name = true, description = true, range = true, type = true,
		icon = true	},
	{	damage = true, number = true, movement_used = true,
		attack_weight = true, defense_weight = true },
	{}

local function invalidExprError(k, v)
	h.wml_error(
		("Invalid expression: [modify_unit_attacks]%s=%q"): format(k, v))
end

function wesnoth.wml_actions.modify_unit_attacks(cfg)
	local units, attackFilter =
		wesnoth.get_units(h.get_child(cfg, "filter")),
		h.get_child(cfg, "filter_attack")
	for i = 1, #units do
		local u, modifiedAttacks = units[i].__cfg, {}
		-- Compute modifications.
		for atk in h.child_range(u, "attack") do
			if lp8.matchAttack(atk, attackFilter) then
				modifiedAttacks[atk] = {}
				for k, v in pairs(cfg) do
					wesnoth.set_variable("this_attack", atk)
					-- FIXME: h.parsed doesn’t touch plain tables.
					-- Write a variable interpolation function.
					varSubstBox.x = tostring(v)
					local x = h.parsed(varSubstBox).x:
						gsub("%?", tostring(atk[k]))
					if stringAttackKeys[k] then
						modifiedAttacks[atk][k] = x
					elseif numericAttackKeys[k] then
						modifiedAttacks[atk][k] = h.round(
							tonumber(x)
							or tonumber(
								(	load("return " .. x)
									or invalidExprError(k,v)
								)()
							)
							or invalidExprError(k,v)
						)
					elseif type(v) == "table" or type(v) == "userdata"
					then
						local t = v[1]
						if t == "specials" then
							h.wml_error "Not yet implemented: [modify_unit_attacks][specials]"
						elseif t ~= "filter" and t ~= "filter_attack" then
							h.wml_error(
								"Unrecognized subtag: [modify_unit_attacks]["
								.. tostring(t) .. "]")
						end
					else
						h.wml_error("Unrecognized key: [modify_unit_attacks]"
							.. k .. "=")
					end
				end
			end
		end
		-- Commit changes.
		for atk, atkcfg in pairs(modifiedAttacks) do
			for k, v in pairs(atkcfg) do
				atk[k] = v
			end
		end
		wesnoth.put_unit(u)
	end
end

