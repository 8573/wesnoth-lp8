
To use 8680’s Lua Pack in your add-on, first declare it as a dependency in
your `_server.pbl`:

	dependencies="8680s_Lua_Pack"

(See also <http://wiki.Wesnoth.org/PblWML>.)

Then put this in your `_main.cfg` (in the campaign or multiplayer `#ifdef`)
for every script you want to use:

	{8680/lua-pack <script-name>}

Don’t include a file extension (e.g., `.lua`) in the `script-name`.

For example:

	{8680/lua-pack modify_unit_attacks}
	{8680/lua-pack some_other_script}

Documentation for each script is available in the `docs` directory.

If you have any problems, go here:
	<https://github.com/8573/wesnoth-lp8/issues>

