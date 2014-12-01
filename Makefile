
default::
	@echo 'Try `make test` or `make release`.' && exit 2


test::
	@cd test && ./main.lua


wamdir?=$(HOME)/src/wesnoth/wesnoth-tools

ignore_failure_to_release_to_old_addons_servers=0
ifroas=$(ignore_failure_to_release_to_old_addons_servers)

release: test
	@./scripts/release.zsh 8680s_Lua_Pack 1.10.x $(wamdir) \
		|| return $$(( ! $(ifroas) ))
	@./scripts/release.zsh 8680s_Lua_Pack 1.11.x $(wamdir) \
		|| return $$(( ! $(ifroas) ))
