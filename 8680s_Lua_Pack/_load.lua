
-- By 8680.

if not namespace_of_8680s_Lua_Pack then
	namespace_of_8680s_Lua_Pack = {}
	lp8 = lp8 == nil and namespace_of_8680s_Lua_Pack or error(
		"8680s_Lua_Pack initialization aborted: global variable lp8 already taken!", 0)
	lp8.helper = wesnoth.require "lua/helper.lua"
	function lp8.require(script)
		assert(lp8 == namespace_of_8680s_Lua_Pack)
		wesnoth.require(dir_of_8680s_Lua_Pack .. script .. ".lua")
	end
end

return lp8.require
