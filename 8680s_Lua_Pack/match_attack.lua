
-- By 8680.

lp8.require "string"

local h, tn, rk = lp8.helper, tonumber,
	{ name = 1, damage = 1, range = 1, type = 1, special = 1 }

local function hasDamage(attack, damages)
	local d = tn(attack.damage)
	for a, b in tostring(damages): gmatch "[^%s,][^,]*" do
		a, b = tn(a) or lp8.gtrim(a): match "^(%d+)%-(%d+)$"
		if b then
			return d >= tn(a) and d <= tn(b)
		else
			return d == a
		end
	end
end
lp8.match_attack_damage = hasDamage

local function hasSpecial(attack, special)
	local specials = h.get_child(attack, "specials")
	for i = 1, #specials do
		if specials[i].id == special then
			return true
		end
	end
	return false
end
lp8.match_attack_special = hasSpecial

local function matchAttack(attack, filter, tagName)
	if filter then
		for k, v in pairs(filter) do
			if type(v) == "table" then
				local t = v[1]
				v = matchAttack(attack, v[2])
				if t == "not" and v or t == "and" and not v then
					return false
				elseif t == "or" and v then
					return true
				else
					h.wml_error(("Unrecognized subtag: [%s][%s]"):
						format(tagName or "filter_attack", t))
				end
			elseif k == "special" and not hasSpecial(attack, v)
					or k == "damage" and not hasDamage(attack, v)
					or rk[k] and attack[k] ~= v then
				return false
			elseif not rk[k] then
				h.wml_error(("Unrecognized key: [%s]%s="):
					format(tagName or "filter_attack", k))
			end
		end
	end
	return true
end
lp8.match_attack = matchAttack

