
-- By 8680, with help from battlestar (testing), Elvish_Hunter (suggestion for
-- $this_attack), pydsigner (filed GitHub issue #2, which was fixed in commit
-- aa8113bbe0509dadf985910f4c1225d1ba00779e).

lp8.require "utils"
lp8.require "string"
lp8.require "match_attack"

local ts, h, stringAttackKeys, numericAttackKeys =
	tostring, lp8.helper
	{	name = true, description = true, range = true, type = true,
		icon = true	},
	{	damage = true, number = true, movement_used = true,
		attack_weight = true, defense_weight = true },

function wesnoth.wml_actions.modify_unit_attacks(cfg)
	local units, attackFilter =
		wesnoth.get_units(h.get_child(cfg, "filter")),
		h.parsed(h.get_child(cfg, "filter_attack"))
	for i = 1, #units do
		local u, modifiedAttacks = units[i].__cfg, {}
		-- Compute modifications.
		for atk in h.child_range(u, "attack") do
			if lp8.matchAttack(atk, attackFilter) then
				modifiedAttacks[atk] = {}
				for k, v in pairs(cfg) do
					local function exprErr()
						h.wml_error(
							("Invalid expression: [modify_unit_attacks]%s=%q"):
								format(k, ts(v)))
					end
					wesnoth.set_variable("this_attack", atk)
					local x = lp8.subst(v): gsub("%?", ts(atk[k]))
					if stringAttackKeys[k] then
						modifiedAttacks[atk][k] = x
					elseif numericAttackKeys[k] then
						modifiedAttacks[atk][k] = h.round(
							tonumber(x) or tonumber(lp8.eval(x, nil, exprErr))
							or exprErr())
					elseif type(v) == "table" or type(v) == "userdata" then
						local t = v[1]
						if t == "specials" then
							lp8.nyiw "[modify_unit_attacks][specials]"
						elseif t ~= "filter" and t ~= "filter_attack" then
							h.wml_error(
								"Unrecognized subtag: [modify_unit_attacks]["
								.. ts(t) .. "]")
						end
					else
						h.wml_error("Unrecognized key: [modify_unit_attacks]"
							.. ts(k) .. "=")
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

